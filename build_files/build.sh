#!/bin/bash

set -ouex pipefail

FEDORA_VERSION=$(rpm -E %fedora)


## Add cosmic extension copr
dnf5.real -y copr enable ligenix/cosmic-ext fedora-${FEDORA_VERSION}-x86_64

## Install packages
dnf5.real -y install cosmic-greeter \
  cosmic-session \
  cosmic-comp \
  cosmic-panel \
  cosmic-settings \
  cosmic-settings-daemon \
  cosmic-workspaces \
  cosmic-applets \
  cosmic-bg \
  cosmic-launcher \
  cosmic-app-library \
  cosmic-notifications \
  cosmic-idle \
  cosmic-osd \
  cosmic-randr \
  cosmic-icon-theme \
  cosmic-edit \
  cosmic-player \
  cosmic-files \
  cosmic-term \
  cosmic-reader \
  xdg-desktop-portal-cosmic \
  cutecosmic-qt6 \
  rakuos-welcome-cosmic \
  rakuos-software-qt \
  cosmic-ext-calculator \
  cosmic-ext-storage \
  cosmic-ext-applet-clipboard-manager \
  cosmic-ext-noctua \
  cosmic-ext-applet-sysinfo \
  cosmic-ext-applet-logomenu \
  cosmic-ext-xcalendar \
  cosmic-ext-tasks \
  cosmic-ext-camera \
  gnome-keyring-pam \
  system-config-printer \
  bluez-cups

## Remove packages
dnf5.real -y remove google-noto-color-emoji-fonts

## remove cosmic-inital-setup autostart

rm /etc/xdg/autostart/com.system76.CosmicInitialSetup.desktop
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
flatpak remote-add --if-not-exists cosmic https://apt.pop-os.org/cosmic/cosmic.flatpakrepo

## Enable Services
systemctl enable cosmic-greeter.service
