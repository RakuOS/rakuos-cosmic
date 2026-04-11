#!/usr/bin/env bash
set -euo pipefail

echo "Swapping Fedora kernel for CachyOS kernel..."
dnf5.real -y copr enable bieszczaders/kernel-cachyos
dnf5.real swap -y kernel kernel-cachyos