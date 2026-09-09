#!/bin/bash
# Downloads, installs, and force-restarts to apply pending macOS updates.
# No dialog, no deferral, no restart choice — restart happens immediately
# after install completes.
#
# --all intentionally excludes major OS upgrades (e.g. macOS 15 -> 26) —
# this script only patches the currently installed major version.
#
# Deploy via Intune/Jamf/WS1 as a root-context script.

LOG_DIR="/Library/Logs/Adobe"
LOG="$LOG_DIR/macosUpdateAndRestart.log"

mkdir -p "$LOG_DIR"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [macosUpdateAndRestart] $*" >> "$LOG"
}

get_current_user() {
    stat -f "%Su" /dev/console 2>/dev/null
}

run_as_user() {
    local user="$1"; shift
    local uid
    uid=$(id -u "$user" 2>/dev/null) || return 1
    launchctl asuser "$uid" osascript "$@"
}

if [[ $EUID -ne 0 ]]; then
    echo "Error: must run as root (sudo)." >&2
    exit 1
fi

CURRENT_USER=$(get_current_user)

log "Checking for macOS updates..."
UPDATE_LIST=$(softwareupdate -l 2>&1)

if echo "$UPDATE_LIST" | grep -q "No new software available"; then
    log "No updates available."
    exit 0
fi

log "Updates found — downloading..."
softwareupdate --download --all >> "$LOG" 2>&1

log "Download complete — installing and restarting."
if [[ -n "$CURRENT_USER" && "$CURRENT_USER" != "root" ]]; then
    run_as_user "$CURRENT_USER" -e \
        'display notification "Installing macOS updates. Your Mac will restart shortly." with title "Software Update"'
fi

softwareupdate --install --all --restart >> "$LOG" 2>&1
INSTALL_EXIT=$?
# --restart only restarts if one of the installed updates actually requires
# it — normal softwareupdate behavior. No unconditional shutdown here.

log "softwareupdate --install exit code: $INSTALL_EXIT"
if [[ $INSTALL_EXIT -ne 0 ]]; then
    log "Install failed — tailing /var/log/install.log for detail:"
    tail -n 100 /var/log/install.log >> "$LOG" 2>&1
fi

exit "$INSTALL_EXIT"
