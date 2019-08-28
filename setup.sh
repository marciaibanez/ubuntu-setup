#!/bin/bash
sudo apt update && sudo apt upgrade

echo "installing apt packages"
sudo apt install git vim fonts-firacode python gnome-session xboxdrv joystick gconf-editor flatpak steam gnome-tweak-tool gnome-software-plugin-flatpak zeal slack darktable krita audacity flowblade curl lmms unzip musescore shotwell gnome-shell-extension-dashtodock gnome-shell-extension-appindicator grub-customizer gcc g++ make

echo "installing snap apps"
sudo snap install spotify
sudo snap install discord
sudo snap install telegram-desktop
sudo snap install code --classic
sudo snap install android-studio --classic

echo "installing Chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

echo "installing whatsapp desktop"
wget https://github.com/Enrico204/Whatsapp-Desktop/releases/download/v0.4.2/whatsapp-desktop-0.4.2-x86_64.AppImage -O whatsapp.appimage

echo "git config"
git config --global user.email "marcia.ibanez.1@gmail.com"
git config --global user.name "Marcia Ibanez"

echo "installing docker"
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
rm get-docker.sh

echo "installing node"
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt install nodejs

echo "installing zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


