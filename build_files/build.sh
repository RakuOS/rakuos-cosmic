#!/bin/bash

set -ouex pipefail

FEDORA_VERSION="${FEDORA_VERSION:-43}"
### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
#dnf5 install -y tmux 

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

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
  cosmic-files \
  cosmic-launcher \
  cosmic-app-library \
  cosmic-store \
  cosmic-edit \
  cosmic-notifications \
  cosmic-idle \
  cosmic-osd \
  cosmic-randr \
  cosmic-screenshot \
  cosmic-player \
  cosmic-term \
  cosmic-icon-theme \
  cosmic-initial-setup \
  xdg-desktop-portal-cosmic \
  cutecosmic-qt6 \
  scx-manager

## Remove packages
#dnf5 -y remove

## Enable COSMIC Flatpak repo
flatpak remote-add --if-not-exists --user cosmic https://apt.pop-os.org/cosmic/cosmic.flatpakrepo

## Enable Services
systemctl enable cosmic-greeter.service