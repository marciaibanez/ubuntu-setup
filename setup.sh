#!/bin/sh
apt update

apt upgrade

echo "installing apt packages"
apt install \
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

echo "installing snap apps"
snap install spotify
snap install discord
snap install telegram-desktop
snap install code --classic
snap install android-studio --classic
snap install slack --classic

echo "installing Chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

echo "git config"
git config --global user.email "marcia.ibanez.1@gmail.com"
git config --global user.name "Marcia Ibanez"

echo "installing docker"
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
rm get-docker.sh

echo "installing node"
curl -sL https://deb.nodesource.com/setup_12.x | bash
apt install nodejs

echo "installing zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"