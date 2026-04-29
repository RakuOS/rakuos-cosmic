#!/bin/bash

set -ouex pipefail

CENTOS_VERSION=$(rpm -E %rhel)

dnf.real -y copr enable ligenix/enterprise-cosmic rhel+epel-$(CENTOS_VERSION)-x86_64

dnf.real -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-$(CENTOS_VERSION).noarch.rpm  
dnf.real -y copr enable ligenix/enterprise-cosmic rhel+epel-$(CENTOS_VERSION)-x86_64

## Install packages
dnf.real -y install @fonts @hardware-support \
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

## Enable COSMIC Flatpak repo
flatpak remote-add --if-not-exists cosmic https://apt.pop-os.org/cosmic/cosmic.flatpakrepo

## Enable Services
systemctl enable cosmic-greeter.service
