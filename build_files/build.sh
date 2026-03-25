#!/bin/bash

set -ouex pipefail

FEDORA_VERSION="${FEDORA_VERSION:-43}"

## Install packages
dnf5 -y install @fonts @hardware-support \
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
  cosmic-initial-setup \
  xdg-desktop-portal-cosmic \
  cutecosmic-qt6 \
  rakuos-welcome-cosmic

## Remove packages
#dnf5 -y remove

## Enable COSMIC Flatpak repo
flatpak remote-add --if-not-exists cosmic https://apt.pop-os.org/cosmic/cosmic.flatpakrepo

## Enable Services
systemctl enable cosmic-greeter.service