# Pawns.app Community Peer Node Deployer

An open, auditable deployment automation suite for running official [Pawns.app](https://pawns.app/) CLI client nodes across consented home lab microservers, developer workstations, and participating peer machines.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Pawns CLI](https://img.shields.io/badge/Client-Official_CLI_Container-green.svg)](https://pawns.app/download/)
[![Compliance](https://img.shields.io/badge/Compliance-Explicit_Consent_Enforced-brightgreen.svg)](PEER_CONSENT_AGREEMENT.md)

---

## 🎯 Project Overview

This repository provides transparent tooling to deploy and manage official Pawns.app nodes in an opt-in, non-intrusive manner. It ensures:

1. **Strict End-User Consent**: Every device deployment requires an interactive confirmation acknowledging the Pawns.app Terms of Use and Bandwidth Sharing Agreement.
2. **Security & Privacy First**:
   - Zero access to user files, credentials, local network resources, or personal data.
   - Operates inside an unprivileged Docker container or standard user-space process.
   - Shares only idle, unused upstream/downstream residential internet bandwidth.
3. **Auditability**: Generates local timestamped consent receipts (`/var/log/pawns/consent-audit.log`) verifying authorized execution.

---

## 🚀 Quick Start

### Prerequisites
- Docker Engine installed (or standalone Linux x86_64 / ARM64 environment)
- Internet connection via standard residential broadband (FTTH)

### Linux & macOS / WSL2
```bash
git clone https://github.com/phannghia1019/pawns-community-deployer.git
cd pawns-community-deployer
chmod +x deploy.sh stop.sh
./deploy.sh
```

### Windows (PowerShell)
```powershell
git clone https://github.com/phannghia1019/pawns-community-deployer.git
cd pawns-community-deployer
.\deploy.ps1
```

---

## 📋 Consent & Onboarding Workflow

When executing `deploy.sh`, the interactive wizard will display:
```text
=========================================================================================
             PAWNS.APP COMMUNITY PEER BANDWIDTH ONBOARDING & CONSENT FLOW               
=========================================================================================
Device Hostname : hn-long-ryzen-ws  |  Platform: Linux x86_64 (Ubuntu 22.04 LTS)
Target Client   : Official Docker Container: iproyal/pawns-cli:latest
-----------------------------------------------------------------------------------------
USER PRIVACY & RESOURCE SHARING DISCLOSURE:
1. Bandwidth Sharing Only: Only unused residential bandwidth is routed via encrypted tunnel.
2. Zero Data Access:       The CLI has zero access to personal files, browsing, or storage.
3. Official Terms:         Terms of Use:   https://pawns.app/terms-of-use/
                           Privacy Policy: https://pawns.app/privacy-policy/
4. Revocation:             You can terminate this node at any time via ./stop.sh.
-----------------------------------------------------------------------------------------
Do you understand the terms and grant consent to share idle bandwidth? (yes/no):
```

Typing `yes` records a SHA-256 verified consent log and pulls the official `iproyal/pawns-cli:latest` image.

---

## 🛑 Stopping or Revoking Consent

To immediately halt the Pawns node and purge local runtime containers:
```bash
./stop.sh
```

---

## 📄 License & Terms

- Automation scripts licensed under the [MIT License](LICENSE).
- All network operations strictly adhere to the [Pawns.app Terms of Service](https://pawns.app/terms-of-use/) and [Privacy Policy](https://pawns.app/privacy-policy/).
