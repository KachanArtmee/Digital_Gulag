#!/bin/bash

dota_pth="$HOME/.local/share/Steam/steamapps/common/dota 2 beta"
manic="$HOME/.local//share/Steam/steamapps/appmanifest_570.acf"

while true; do 
	if [ -d "$dota_pth" ]; then
		pkill -9 steam
		rm -rf "$dota_pth"
		rm -f "$manic"
		
		notify-send "bitch DELETED"
	fi
	sleep 600
done


