#!/bin/bash

echo "installing Linux Productivity Guardian..."

if[ "$EUID" -ne 0 ] then
	echo "you need to run this using sudo. type 'sudo install.sh'"
	exit 1
fi

user_real=${SUDO_USER:-$USER}

echo "start installing..."

cp scripts/uninstall-dota.sh /usr/local/bin/focus-enforcer
chmod  +x /usr/local/bin/focus-enforcer

cp systemd/productivity.service /etc/systemd/system/

sed -i "s/User=USER/User=$user_real/" /etc/systemd/system/productivity.service

systemctl daemon-reload
systemctl enable --now productivity.service

echo "Installation complete. Thank u for ur support"
