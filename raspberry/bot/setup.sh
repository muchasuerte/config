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
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
    )

    echo -n "$SYSTEMD_FTBOT" > /etc/systemd/system/ftbot.service
    systemctl daemon-reload
    systemctl enable ftbot.service
}

systemd_init() {
    UWSGI_FTBOT=$(cat <<EOF
[uwsgi]
uid = pi
gid = pi
processes = 1
master = 1
plugin = python3
virtualenv = /home/pi/bot/env
http-socket = 127.0.0.1:5000
module = ft_bot:app
enable-threads = true
chdir = /home/pi/bot
EOF

    echo -n "$UWSGI_FTBOT" > /etc/uwsgi/apps-enabled/ftbot.ini
    service uwsgi reload
}

case $1 in
    venv)
        venv_init
    ;;
    system)
        if [ "$(id -u)" != "0" ]; then
            echo "Super user required"
            exit 1
        fi

        apt-get install -y uwsgi uwsgi-plugin-python3
        systemd_init "$(dirname $(readlink -f $0))"
    ;;
    *)
        echo "Usage: $0 venv|system"
    ;;
esac
