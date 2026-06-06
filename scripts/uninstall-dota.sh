#!/bin/bash

CONFIG_FILE="$(dirname "$0")/../guardian.conf"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Ошибка: Файл конфигурации $CONFIG_FILE не найден!"
    exit 1
fi

while true; do
    source "$CONFIG_FILE"
    TRIGGERED=false

    for path in "${BAD_PATHS[@]}"; do
        eval actual_path="$path"
        if [ -d "$actual_path" ] || [ -f "$actual_path" ]; then
            rm -rf "$actual_path"
            TRIGGERED=true
        fi
    done

    if [ "$TRIGGERED" = true ]; then
        if [ "$MODE" = "aggressive" ]; then
            for process in "${BAD_PROCESSES[@]}"; do
                pkill -9 -f "$process" 2>/dev/null
            done
        fi

        if [ "$MODE" != "silent" ]; then
            notify-send "Productivity Guardian" "Запрещенный софт обнаружен и аннигилирован!" --icon=dialog-warning
        fi
    fi

    sleep "$CHECK_INTERVAL"
done