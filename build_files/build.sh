#!/bin/bash

set -ouex pipefail

FEDORA_VERSION=$(rpm -E %fedora)

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
  xdg-desktop-portal-cosmic \
  cutecosmic-qt6 \
  rakuos-welcome-cosmic \
  rakuos-software-qt \
  cosmic-initial-setup

## Remove packages
#dnf5.real -y remove

## Remove Fedora Wallpapers
#rm -rf/usr/share/backgrounds/f${FEDORA_VERSION}
#rm -rf/usr/share/backgrounds/f${FEDORA_VERSION}

## Enable COSMIC Flatpak repo
flatpak remote-add --if-not-exists cosmic https://apt.pop-os.org/cosmic/cosmic.flatpakrepo

## Enable Services
systemctl enable cosmic-greeter.service
