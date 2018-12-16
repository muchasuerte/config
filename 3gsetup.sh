#!/bin/bash

WVDIAL_CONF=$(cat <<EOF
[Dialer vod]
Modem = /dev/ttyUSB2
Username = "blank"
Password = "blank"

# Port speeds that're worth testing:
# 921600
# 460800
# 115200
#  57600
Baud = 460800
Init1 = AT+CGDCONT=1,"ip","web.omnitel.it","0.0.0.0",0,0

# Most services/devices dial with *99# . A few seem to require *99***1#
Phone = *99#
EOF
)

SYSTEMD_WVDIAL=$(cat <<EOF
# modem-attachment.service
[Unit]
Description=3G Modem

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/local/bin/modem_3g.sh

[Install]
WantedBy=multi-user.target
EOF
)

UDEV_RULE=$(cat <<EOF
ATTR{idVendor}=="19d2", ATTR{idProduct}=="0037", TAG+="systemd", ENV{SYSTEMD_WANTS}="modem-3g.service", SYMLINK+="modem-onda"
EOF
)

SCRIPT=$(cat <<EOF
#!/bin/bash
/usr/bin/wvdial vod
EOF
)

echo -n "$WVDIAL_CONF" > /etc/wvdial.conf
echo -n "$SYSTEMD_WVDIAL" > /etc/systemd/system/modem-3g.service
echo -n "$UDEV_RULE" > /etc/udev/rules.d/99-3g.rules
echo -n "$SCRIPT" > /usr/local/bin/modem_3g.sh
chmod +x /usr/local/bin/modem_3g.sh
addgroup pi dip
systemctl daemon-reload
systemctl enable modem-3g.service

