#!/bin/bash

set -ouex pipefail

FEDORA_VERSION=$(rpm -E %fedora)

## Install packages
dnf5.real -y install \
  --exclude=noctalia* \
  bluez-cups \
  cosmic-app-library \
  cosmic-applets \
  cosmic-bg \
  cosmic-comp \
  cosmic-edit \
  cosmic-applet-clippy-land \
  cosmic-ext-applet-logomenu \
  cosmic-ext-applet-sysinfo \
  cosmic-ext-calculator \
  cosmic-ext-camera \
  cosmic-ext-noctua \
  cosmic-ext-storage \
  cosmic-ext-tasks \
  cosmic-ext-xcalendar \
  cosmic-files \
  cosmic-greeter \
  cosmic-icon-theme \
  cosmic-idle \
  cosmic-launcher \
  cosmic-notifications \
  cosmic-osd \
  cosmic-panel \
  cosmic-player \
  cosmic-randr \
  cosmic-reader \
  cosmic-session \
  cosmic-settings \
  cosmic-settings-daemon \
  cosmic-term \
  cosmic-workspaces \
  cutecosmic-qt6 \
  gnome-keyring-pam \
  NetworkManager-openvpn-gnome \
  NetworkManager-strongswan-gnome \
  NetworkManager-wifi \
  rakuos-software-qt \
  rakuos-welcome-cosmic \
  system-config-printer \
  xdg-desktop-portal-cosmic

## Remove packages
dnf5.real -y remove google-noto-color-emoji-fonts

## Emoji Cosmic Terminal fix
mkdir -p /usr/share/fonts/google-noto-color-emoji-fonts && \
curl -fLo /usr/share/fonts/google-noto-color-emoji-fonts/NotoColorEmoji.ttf "https://github.com/googlefonts/noto-emoji/raw/main/fonts/NotoColorEmoji.ttf" && \
fc-cache -f /usr/share/fonts/google-noto-color-emoji-fonts

## Remove Fedora Wallpapers
rm -rf /usr/share/backgrounds/fedora-workstation
rm -rf /usr/share/backgrounds/images
rm -rf /usr/share/backgrounds/cosmic
rm -rf /usr/share/wallpapers/Next
rm -rf /usr/share/backgrounds/f43
rm -rf /usr/share/backgrounds/f44
rm -f /usr/share/backgrounds/default.jxl
rm -f /usr/share/backgrounds/default-dark.jxl
rm -f /usr/share/backgrounds/default.xml

## Enable COSMIC Flatpak repo
#flatpak remote-add --if-not-exists cosmic https://apt.pop-os.org/cosmic/cosmic.flatpakrepo

## Enable Services
systemctl enable cosmic-greeter.service

## Enable user service
#systemctl enable --global cosmic-flux-daemon.service
