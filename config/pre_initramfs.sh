#!/usr/bin/env bash
set -euo pipefail
FEDORA_VERSION=$(rpm -E %fedora)

echo "Swapping Fedora kernel for CachyOS kernel..."
dnf5.real -y copr enable bieszczaders/kernel-cachyos fedora-${FEDORA_VERSION}-x86_64
dnf5.real swap -y kernel kernel-cachyos