#!/bin/bash
# infinipointInstaller.sh
# Installs the Infinipoint agent if not already present, verifies installation,
# retries once on failure, and logs results to /Library/Logs/Adobe.

# ── Configuration ─────────────────────────────────────────────────────────────
readonly TENANT_ID="42fbb743-00e4-481e-a82a-2c4f0462fda2"
readonly INSTALLER_URL="https://storage.googleapis.com/infinipoint-prod-usa-agent-release/infp_macos_latest.sh"
readonly INSTALLER_TMP="/tmp/infp_macos_latest.sh"
readonly LOG_DIR="/Library/Logs/Adobe"
readonly LOG_FILE="${LOG_DIR}/infinipoint_install.log"
readonly MAX_RETRIES=1

# Infinipoint is confirmed installed when installer.log exists inside /Library/infp
readonly AGENT_INSTALL_LOG="/Library/infp/installer.log"

# ── Logging ───────────────────────────────────────────────────────────────────
log() {
    local level="$1"
    local message="$2"
    local timestamp
    timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo "${timestamp} [${level}] ${message}" | tee -a "${LOG_FILE}"
}

# ── Bootstrap log directory ───────────────────────────────────────────────────
mkdir -p "${LOG_DIR}"

log "INFO" "======== Infinipoint Installer Start ========"

# ── Detection: is the agent already installed? ────────────────────────────────
is_installed() {
    # installer.log present = agent fully installed; empty /Library/infp dir = not installed
    [[ -f "${AGENT_INSTALL_LOG}" ]]
}

# ── Verification: did the agent come up after install? ────────────────────────
verify_installation() {
    # Allow up to 30 seconds for the agent to start
    local attempts=6
    local wait_sec=5
    for ((i = 1; i <= attempts; i++)); do
        if is_installed; then
            log "INFO" "Verification passed (attempt ${i}/${attempts})."
            return 0
        fi
        log "INFO" "Agent not detected yet — waiting ${wait_sec}s (attempt ${i}/${attempts})..."
        sleep "${wait_sec}"
    done
    log "ERROR" "Verification failed: agent not detected after $((attempts * wait_sec))s."
    return 1
}

# ── Installer download + execution ───────────────────────────────────────────
run_installer() {
    log "INFO" "Downloading installer from ${INSTALLER_URL}"
    if ! curl -sLo "${INSTALLER_TMP}" "${INSTALLER_URL}"; then
        log "ERROR" "Download failed."
        return 1
    fi

    log "INFO" "Running installer (tenant: ${TENANT_ID})"
    if ! sudo bash "${INSTALLER_TMP}" -- -d "${TENANT_ID}"; then
        log "ERROR" "Installer script exited with a non-zero status."
        rm -f "${INSTALLER_TMP}"
        return 1
    fi

    rm -f "${INSTALLER_TMP}"
    return 0
}

# ── Main logic ────────────────────────────────────────────────────────────────
if is_installed; then
    log "INFO" "Infinipoint is already installed. Nothing to do."
    log "INFO" "======== Infinipoint Installer End (skipped) ========"
    exit 0
fi

log "INFO" "Infinipoint not detected. Starting installation (attempt 1)."

attempt=0
success=false

while (( attempt <= MAX_RETRIES )); do
    (( attempt++ ))

    if (( attempt > 1 )); then
        log "WARN" "Retrying installation (attempt ${attempt})."
    fi

    if run_installer && verify_installation; then
        success=true
        break
    fi

    log "WARN" "Attempt ${attempt} did not produce a verified install."
done

if ${success}; then
    log "INFO" "Infinipoint installed and verified successfully."
    log "INFO" "======== Infinipoint Installer End (success) ========"
    exit 0
else
    log "ERROR" "Infinipoint installation FAILED after ${attempt} attempt(s). Manual intervention required."
    log "INFO" "======== Infinipoint Installer End (FAILED) ========"
    exit 1
fi
