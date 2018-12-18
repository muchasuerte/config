#!/bin/bash

venv_init() {
    if [ ! -e "env" ]; then
        virtualenv -p python3 env
    fi

    if [ -e "env/bin/activate" ]; then
        source env/bin/activate
        pip install -r requirements.txt
        deactivate
    fi
}

systemd_init() {
    SYSTEMD_FTBOT=$(cat <<EOF
[Unit]
Description=My Flask Telegram Bot
#After=modem_3g.service

[Service]
Type=simple
User=pi
ExecStart=$1/ftbot.sh
WorkingDirectory=$1
Restart=always
RemainAfterExit=no

[Install]
WantedBy=multi-user.target
EOF
    )

    echo -n "$SYSTEMD_FTBOT" > /etc/systemd/system/ftbot.service
    systemctl daemon-reload
    systemctl enable ftbot.service
}

uwsgi_init() {
    UWSGI_FTBOT=$(cat <<EOF
[uwsgi]
uid = pi
gid = pi
processes = 1
master = 1
plugin = python3
virtualenv = $1/env
http-socket = 127.0.0.1:5000
module = ft_bot:app
enable-threads = true
chdir = $1
EOF
    )

    echo -n "$UWSGI_FTBOT" > /etc/uwsgi/apps-enabled/ftbot.ini
    service uwsgi reload
}

check_superuser() {
    if [ "$(id -u)" != "0" ]; then
        echo "Super user required"
        exit 1
    fi
}

case $1 in
    venv)
        venv_init
    ;;
    system)
        check_superuser
        systemd_init "$(dirname $(readlink -f $0))"
    ;;
    uwsgi)
        check_superuser
        apt-get install -y uwsgi uwsgi-plugin-python3
        uwsgi_init "$(dirname $(readlink -f $0))"
    ;;
    apcups)
        check_superuser
        cp default.httptrigger /etc/apcupsd/onbattery
        cp default.httptrigger /etc/apcupsd/offbattery
    ;;
    logs)
        check_superuser
        if [ -e "/etc/systemd/system/ftbot.service" ]; then
            journalctl -u ftbot.service -fn
        fi
        if [ -e "/etc/uwsgi/apps-enabled/ftbot.ini" ]; then
            tailf /var/log/uwsgi/app/ftbot.log
        fi        
    ;;
    *)
        echo "Usage: $0 venv|system|apcups"
    ;;
esac
