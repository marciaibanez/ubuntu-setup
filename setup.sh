#!/bin/sh
set -e
export DEBIAN_FRONTEND=noninteractive

apt update && apt full-upgrade -y

echo "Installing apt packages"
apt-get install chrome-gnome-shell \
apt install -y \
     git \
     vim \
     fonts-firacode \
     python \
     gnome-session \
     xboxdrv \
     joystick \
     gconf-editor \
     steam \
     gnome-tweak-tool \
     gnome-software-plugin-flatpak \
     zeal \
     darktable \
     krita \
     audacity \
     flowblade \
     curl \
     lmms \
     unzip \
     musescore \
     shotwell \
     grub-customizer \
     gcc \
     g++ \
     make \
     zsh

echo "Running auto-remove"
apt autoremove -y
apt autoclean

echo "Installing snap apps"
snap install spotify
snap install discord
snap install telegram-desktop
snap install code --classic
snap install android-studio --classic
snap install slack --classic
snap install whatsdesk

echo "Installing Chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

echo "Configuring git"
git config --global user.email "marcia.ibanez.1@gmail.com"
git config --global user.name "Marcia Ibanez"

echo "Installing docker"
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
rm get-docker.sh
usermod -aG docker marciaibanez

echo "Installing node"
curl -sL https://deb.nodesource.com/setup_12.x | bash
apt install nodejs

echo "Installing zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Installing docker compose"
curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo "Making linux use local time..."
timedatectl set-local-rtc 1 --adjust-system-clock

echo "Installing fallout grub theme"
wget -O - https://github.com/shvchk/fallout-grub-theme/raw/master/install.sh | bash

echo "Installing Stacer"
sudo add-apt-repository ppa:oguzhaninan/stacer
sudo apt update && sudo apt install stacer
