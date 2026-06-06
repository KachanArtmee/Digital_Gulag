#!/bin/bash

CONFIG_FILE="$(dirname "$0")/../config/guardian.conf"

MODE="dry-run"
CHECK_INTERVAL=600
BAD_PATHS=()
BAD_PROCESSES=()

CRITICAL_SYSTEM_PATHS=(
    "/"
    "/etc"
    "/boot"
    "/root"
    "/bin"
    "/sbin"
    "/lib"
    "/lib64"
    "/usr"
    "/usr/bin"
    "/usr/sbin"
    "/usr/lib"
    "/var"
    "/proc"
    "/sys"
    "/dev"
    "/home"
)

check_dependencies() {
    local missing_critical=false

    for cmd in logger pkill; do
        if ! command -v "$cmd" &>/dev/null; then
            echo "Ошибка: Не найдена критическая системная команда: $cmd" >&2
            missing_critical=true
        fi
    done

    if [ "$missing_critical" = true ]; then
        exit 1
    fi

    if ! command -v notify-send &>/dev/null; then
        HAS_NOTIFY=false
    else
        HAS_NOTIFY=true
    fi
}

log_message() {
    local level="$1"
    local message="$2"
    logger -t "productivity-guardian" "[$level] $message"
}

expand_path() {
    local p="$1"
    if [[ "$p" == "~/"* ]]; then
        echo "${p/#\~/$HOME}"
    elif [[ "$p" == "~" ]]; then
        echo "$HOME"
    else
        echo "$p"
    fi
}

validate_config() {
    local file="$1"
    
    if ! [[ -f "$file" && -r "$file" ]]; then
        return 1
    fi

    if ! bash -n "$file" 2>/dev/null; then
        return 1
    fi

    (
        source "$file"
        if ! [[ "$CHECK_INTERVAL" =~ ^[0-9]+$ ]] || [ "$CHECK_INTERVAL" -le 0 ]; then
            exit 1
        fi
        if [[ "$MODE" != "soft" && "$MODE" != "aggressive" && "$MODE" != "silent" && "$MODE" != "dry-run" ]]; then
            exit 1
        fi
    )
    return $?
}

is_path_safe() {
    local p="$1"
    
    if [ -z "$p" ]; then
        return 1
    fi
    
    if [ ${#p} -le 5 ]; then
        return 1
    fi

    for sys_path in "${CRITICAL_SYSTEM_PATHS[@]}"; do
        if [[ "$p" == "$sys_path" ]] || [[ "$p" == "$sys_path/" ]]; then
            return 1
        fi
    done

    if [[ "$p" == "$HOME" ]] || [[ "$p" == "$HOME/" ]]; then
        return 1
    fi
    
    if [[ "$p" != "$HOME/"* ]]; then
        return 1
    fi
    
    return 0
}

check_dependencies

if validate_config "$CONFIG_FILE"; then
    source "$CONFIG_FILE"
    log_message "INFO" "Guardian started with user config. Mode: $MODE, Interval: $CHECK_INTERVAL"
else
    log_message "CRITICAL" "Config at $CONFIG_FILE is missing or corrupted on startup! Using safe defaults. Mode: $MODE, Interval: $CHECK_INTERVAL"
fi

while true; do
    if validate_config "$CONFIG_FILE"; then
        source "$CONFIG_FILE"
    else
        log_message "WARN" "Config is invalid or corrupted. Keeping previous stable settings."
    fi

    FILES_TRIGGERED=false
    PROCESSES_TRIGGERED=false

    for path in "${BAD_PATHS[@]}"; do
        actual_path=$(expand_path "$path")

        if [ -d "$actual_path" ] || [ -f "$actual_path" ]; then
            if is_path_safe "$actual_path"; then
                log_message "INFO" "Target detected: $actual_path [Mode: $MODE]"
                
                if [ "$MODE" != "dry-run" ]; then
                    if rm -rf "$actual_path"; then
                        log_message "INFO" "Target successfully deleted: $actual_path"
                    else
                        log_message "ERROR" "Failed to delete target: $actual_path"
                    fi
                else
                    log_message "DRY-RUN" "Skipped deletion of: $actual_path"
                fi
                FILES_TRIGGERED=true
            else
                log_message "CRITICAL" "Dangerous path skipped from deletion: $actual_path"
            fi
        fi
    done

    for process in "${BAD_PROCESSES[@]}"; do
        if pkill -0 -f "$process" 2>/dev/null; then
            log_message "INFO" "Target process alive: $process [Mode: $MODE]"
            
            if [ "$MODE" == "soft" ]; then
                pkill -f "$process" 2>/dev/null
                log_message "INFO" "Sent SIGTERM to process: $process"
            elif [[ "$MODE" == "aggressive" || "$MODE" == "silent" ]]; then
                pkill -f "$process" 2>/dev/null
                sleep 1
                if pkill -0 -f "$process" 2>/dev/null; then
                    pkill -9 -f "$process" 2>/dev/null
                    log_message "WARN" "Sent SIGKILL to stubborn process: $process"
                fi
            elif [ "$MODE" == "dry-run" ]; then
                log_message "DRY-RUN" "Skipped killing process: $process"
            fi
            PROCESSES_TRIGGERED=true
        fi
    done

    if [[ "$FILES_TRIGGERED" = true || "$PROCESSES_TRIGGERED" = true ]]; then
        if [[ "$MODE" != "silent" && "$MODE" != "dry-run" && "$HAS_NOTIFY" = true ]]; then
            notify-send "Productivity Guardian" "Запрещенная активность обнаружена и пресечена!" --icon=dialog-warning
        fi
    fi

    sleep "$CHECK_INTERVAL"
done