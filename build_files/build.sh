#!/bin/bash

set -ouex pipefail

FEDORA_VERSION=$(rpm -E %fedora)

# On the staging branch (RAKUOS_STAGING=1, set via --build-arg from CI)
# install the staging os-release identity instead of the stable one, so
# staging images identify themselves as "RakuOS COSMIC Staging".
RAKUOS_RELEASE_PKG="rakuos-release-cosmic"
if [ "${RAKUOS_STAGING:-0}" = "1" ]; then
    RAKUOS_RELEASE_PKG="rakuos-release-cosmic-staging"
fi

# Terra ships disabled by default (third-party repos are opt-in), so enable
# it here in case any packages below come from Terra; post-build.sh disables
# it again before the image is finalized.
rum config-manager --default --set-enabled terra
# RPM Fusion is disabled in the base image too; turn its default repos back
# on (the list base post-build.sh recorded). post-build.sh disables them again.
rum config-manager --default --set-enabled $(cat /usr/share/rakuos/rpmfusion-default-repos)

## Install packages
rum install -y \
  --exclude=noctalia* --skip-broken --skip-unavailable \
  cosmic-edit \
  cosmic-applet-clippy-land \
  cosmic-ext-applet-logomenu \
  cosmic-ext-applet-sysinfo \
  cosmic-ext-calculator \
  cosmic-ext-camera \
  cosmic-viewer \
  cosmic-ext-storage \
  cosmic-ext-xcalendar \
  cosmic-monitor \
  cosmic-player \
  cosmic-reader \
  cosmic-session \
  cosmic-ext-applet-workspace-icons \
  cutecosmic-qt6 \
  NetworkManager-openvpn-gnome \
  NetworkManager-strongswan-gnome \
  ${RAKUOS_RELEASE_PKG} \
  rakuos-software-cosmic \
  rakuos-system-cosmic \
  rakuos-welcome-cosmic \
  system-config-printer

## Remove packages
rum remove -y google-noto-color-emoji-fonts

## start-cosmic: only import SSH_AUTH_SOCK when it's set
# cosmic-session's start-cosmic runs `systemctl --user import-environment ...
# SSH_AUTH_SOCK` unconditionally. Without gnome-keyring (45) nothing sets it,
# so every login printed "Environment variable $SSH_AUTH_SOCK not set,
# ignoring." Import it only when it has a value.
START_COSMIC=/usr/bin/start-cosmic
sed -i 's/^\(    systemctl --user import-environment XDG_SESSION_TYPE XDG_CURRENT_DESKTOP DCONF_PROFILE\) SSH_AUTH_SOCK$/\1 ${SSH_AUTH_SOCK:+SSH_AUTH_SOCK}/' "$START_COSMIC"
grep -q 'DCONF_PROFILE ${SSH_AUTH_SOCK:+SSH_AUTH_SOCK}$' "$START_COSMIC" \
    || { echo "ERROR: patching $START_COSMIC failed (cosmic-session layout changed?)"; exit 1; }

## Emoji Cosmic Terminal fix
mkdir -p /usr/share/fonts/google-noto-color-emoji-fonts && \
curl -fLo /usr/share/fonts/google-noto-color-emoji-fonts/NotoColorEmoji.ttf "https://github.com/googlefonts/noto-emoji/raw/main/2D/fonts/NotoColorEmoji.ttf" && \
fc-cache -f /usr/share/fonts/google-noto-color-emoji-fonts

## Remove Fedora Wallpapers
rm -rf /usr/share/backgrounds/fedora-workstation
rm -rf /usr/share/backgrounds/images
rm -rf /usr/share/backgrounds/cosmic
rm -rf /usr/share/wallpapers/Next
rm -rf /usr/share/backgrounds/f${FEDORA_VERSION}
rm -f /usr/share/backgrounds/default.jxl
rm -f /usr/share/backgrounds/default-dark.jxl
rm -f /usr/share/backgrounds/default.xml

## Enable COSMIC Flatpak repo
#flatpak remote-add --if-not-exists cosmic https://apt.pop-os.org/cosmic/cosmic.flatpakrepo

## Enable Services
systemctl enable cosmic-greeter.service

## Enable user service
#systemctl enable --global cosmic-flux-daemon.service
