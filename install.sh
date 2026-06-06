#!/bin/bash

echo "Installing Linux Productivity Guardian..."

if [ "$EUID" -ne 0 ]; then
    echo "Error: You need to run this using sudo. Type 'sudo ./install.sh'" >&2
    exit 1
fi

user_real=${SUDO_USER:-$USER}
user_home=$(eval echo "~$user_real")

echo "Start installing..."

cp scripts/guardian.sh /usr/local/bin/productivity-guardian
chmod +x /usr/local/bin/productivity-guardian

if [ ! -f "config/guardian.conf" ] && [ -f "config/guardian.conf.example" ]; then
    cp config/guardian.conf.example config/guardian.conf
    chown "$user_real":"$user_real" config/guardian.conf
    echo "Created default config from example template."
fi

if [ -f "systemd/productivity-guardian.service" ]; then
    cp systemd/productivity-guardian.service /etc/systemd/system/
else
    cp systemd/productivity.service /etc/systemd/system/productivity-guardian.service 2>/dev/null || true
fi

sed -i "s/User=USER/User=$user_real/" /etc/systemd/system/productivity-guardian.service

systemctl daemon-reload
systemctl enable --now productivity-guardian.service

echo "Installation complete. Thank you for your support!"