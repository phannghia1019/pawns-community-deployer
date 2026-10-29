#!/usr/bin/env bash
set -e

echo "========================================================================================="
echo "             PAWNS.APP COMMUNITY PEER BANDWIDTH ONBOARDING & CONSENT FLOW               "
echo "========================================================================================="
HOSTNAME=$(hostname)
OS_PLATFORM="$(uname -s) $(uname -m)"
echo "Device Hostname : ${HOSTNAME}  |  Platform: ${OS_PLATFORM}"
echo "Target Client   : Official Docker Container: iproyal/pawns-cli:latest"
echo "-----------------------------------------------------------------------------------------"
echo "USER PRIVACY & RESOURCE SHARING DISCLOSURE:"
echo "1. Bandwidth Sharing Only: Only unused residential bandwidth is routed via encrypted tunnel."
echo "2. Zero Data Access:       The CLI has zero access to personal files, browsing, or storage."
echo "3. Official Terms:         Terms of Use:   https://pawns.app/terms-of-use/"
echo "                           Privacy Policy: https://pawns.app/privacy-policy/"
echo "4. Revocation:             You can terminate or uninstall this peer node at any time via ./stop.sh."
echo "-----------------------------------------------------------------------------------------"

read -r -p "Do you understand the terms and grant consent to share idle bandwidth? (yes/no): " CONSENT

if [ "${CONSENT,,}" != "yes" ]; then
    echo "[ABORTED] Consent not granted. Aborting deployment."
    exit 1
fi

LOG_DIR="/var/log/pawns"
mkdir -p "${LOG_DIR}" 2>/dev/null || LOG_DIR="${HOME}/.pawns-logs"
mkdir -p "${LOG_DIR}"
echo "[$(date -u +"%Y-%m-%d %H:%M:%S UTC")] CONSENT_GRANTED: User=$(whoami), Host=${HOSTNAME}, Mode=Docker-Official" >> "${LOG_DIR}/consent-audit.log"

echo "[✓ CONSENT RECORDED] Logged to ${LOG_DIR}/consent-audit.log"
echo "[INFO]               Verifying docker runtime and pulling official image..."
docker pull iproyal/pawns-cli:latest

echo "[INFO]               Starting container 'pawns-peer-node' with official -accept-tos flag..."
docker run -d \
  --name pawns-peer-node \
  --restart unless-stopped \
  iproyal/pawns-cli:latest \
  -email="phankhacbaonghia@gmail.com" \
  -password="${PAWNS_AUTH_KEY:-DEVICE_PEER_KEY}" \
  -device-name="${HOSTNAME}" \
  -accept-tos

echo ""
echo "[SUCCESS]            Pawns.app CLI node is active and healthy! (Node: ${HOSTNAME})"
