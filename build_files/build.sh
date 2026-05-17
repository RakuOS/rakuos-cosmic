#!/bin/bash

set -ouex pipefail

FEDORA_VERSION=$(rpm -E %fedora)


## Add cosmic extension copr
dnf5 -y copr enable ligenix/cosmic-ext fedora-${FEDORA_VERSION}-x86_64

## Install packages
dnf5.real -y install @fonts @hardware-support \
  cosmic-greeter \
  cosmic-session \
  cosmic-comp \
  cosmic-panel \
  cosmic-settings \
  cosmic-settings-daemon \
  cosmic-wallpapers \
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
  xdg-desktop-portal-cosmic \
  cutecosmic-qt6 \
  rakuos-welcome-cosmic \
  rakuos-software-cosmic \
  cosmic-initial-setup \
  cosmic-ext-calculator \
  cosmic-ext-storage \
  cosmic-ext-applet-clipboard-manager \
  cosmic-ext-noctua \
  cosmic-ext-applet-sysinfo \
  cosmic-ext-applet-logomenu \
  cosmic-ext-xcalendar \
  cosmic-ext-tasks \
  cosmic-ext-camera

## Remove packages
dnf5.real -y remove google-noto-color-emoji-fonts

## Emoji Cosmic Terminal fix
sudo mkdir -p /usr/local/share/fonts/truetype && \
sudo curl -fLo /usr/local/share/fonts/truetype/NotoColorEmoji.ttf "https://github.com/googlefonts/noto-emoji/raw/main/fonts/NotoColorEmoji.ttf" && \
sudo fc-cache -f /usr/local/share/fonts/truetype

## Add custom icons
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git /tmp/WhiteSur-icon-theme
/tmp/WhiteSur-icon-theme/install.sh -b -a -t all
rm -rf /tmp/WhiteSur-icon-theme

## Remove Fedora Wallpapers
rm -rf /usr/share/backgrounds/cosmic
rm -rf /usr/share/backgrounds/fedora-workstation
rm -rf /usr/share/backgrounds/images
rm -rf /usr/share/backgrounds/f43
rm -f /usr/share/backgrounds/default.jxl
rm -f /usr/share/backgrounds/default-dark.jxl
rm -f /usr/share/backgrounds/default.xml

## Enable COSMIC Flatpak repo
flatpak remote-add --if-not-exists cosmic https://apt.pop-os.org/cosmic/cosmic.flatpakrepo

## Enable Services
systemctl enable cosmic-greeter.service
