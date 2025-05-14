#!/bin/sh
set -e

# color vars
reset="\033[0m"
success="\033[32m"
warning="\033[33m"
main="\033[34m"

# env vars
export DEBIAN_FRONTEND=noninteractive
export RUNZSH=no

# Helper functions
get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" |
    grep '"tag_name":' |
    sed -E 's/.*"([^"]+)".*/\1/'
}

exists() {
  command -v "$1" >/dev/null 2>&1
}

step() {
  echo "\n$main> $1$reset..."
}

check() {
  echo "$success> ✅$reset"
}

warning() {
  echo "$warning>⚠️  $1"
}

install_chrome() {
  step "Installing Google Chrome"

  if exists google-chrome; then
    warning "Google Chrome is already installed, skipping install"
  else
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
    sudo apt update && sudo apt install -y google-chrome-stable
  fi

  check
}

install_docker() {
  step "Installing Docker"

  if exists docker; then
    warning "Docker is already installed, skipping install"
  else
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    rm get-docker.sh
    sudo usermod -aG docker $USER
    docker --version
  fi

  check
}

install_nodejs() {
  step "Installing NodeJS"

  if exists node; then
    warning "NodeJS is already installed, skipping install"
  else
    curl -sL https://deb.nodesource.com/setup_22.x | sudo -E bash -
    sudo apt install -y nodejs
    node --version
  fi

  check
}

install_stacer() {
  step "Installing Stacer"

  if exists stacer; then
    warning "Stacer is already installed, skipping install"
  else
    sudo apt install -y stacer
  fi

  check
}

install_steam() {
  step "Installing Steam"

  if exists steam; then
    warning "Steam is already installed, skipping install"
  else
    sudo apt install -y steam
  fi

  check
}

install_telegram() {
  step "Installing Telegram"

  if exists telegram-desktop; then
    warning "Telegram is already installed, skipping install"
  else
    sudo snap install telegram-desktop
  fi

  check
}

install_spotify() {
  step "Installing Spotify"

  if exists spotify; then
    warning "Spotify is already installed, skipping install"
  else
    curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
    echo "deb https://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt-get update && sudo apt-get install -y spotify-client
  fi

  check
}

install_discord() {
  step "Installing Discord"

  if exists discord; then
    warning "Discord is already installed, skipping install"
  else
    wget "https://discordapp.com/api/download?platform=linux&format=deb" -O discord.deb
    sudo dpkg -i discord.deb
    sudo apt install -f
    sudo rm discord.deb
  fi

  check
}

install_vscode() {
  step "Installing Visual Studio Code"

  if exists code; then
    warning "Visual Studio Code is already installed, skipping install"
  else
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg
    sudo apt install -y apt-transport-https
    sudo apt update
    sudo apt install -y code
  fi

  check
}

install_firacode() {
  step "Installing Fira Code Font"

  if fc-list | grep -qi "Fira Code"; then
    warning "Fira Code Font is already installed, skipping install"
  else
    sudo apt update && sudo apt install -y fonts-firacode
  fi

  check
}

configure_zsh() {
  step "Configuring ZSH"
  chsh -s $(which zsh)

  if [ -f "$HOME/.zshrc" ]; then
    warning ".zshrc already exists, skipping installation"
  else
    cp "$(dirname "$0")/.zshrc" "$HOME/.zshrc"
    check
  fi
}

update_system() {
  step "Updating system"
  sudo apt update && sudo apt full-upgrade -y
  check
}

remove_apt_packages() {
  step "Removing APT packages"
  sudo apt purge -y apport
  check
}

install_apt_packages() {
  step "Installing APT packages"
  sudo apt install -y \
    software-properties-common \
    git \
    zsh \
    curl \
    htop \
    build-essential
  check
}

clean_apt_packages() {
  step "Cleaning APT packages"
  sudo apt autoremove -y
  check
}

configure_local_time() {
  step "Configure date to use Local Time"
  sudo timedatectl set-local-rtc 1 --adjust-system-clock
  check
}

configure_git() {
  step "Configuring Git"
  git config --global user.name "Marcia Ibanez"
  git config --global user.email "marcia.ibanez.1@gmail.com"
  git config --global tag.sort -version:refname
  check
}

create_projects_folder() {
  step "Creating projects folder"
  mkdir -p ~/projects
  check
}

setup() {
  echo "\n Marcia's Ubuntu 24.04 Setup"

  update_system
  remove_apt_packages
  install_apt_packages
  clean_apt_packages

  install_chrome
  install_docker
  install_nodejs
  install_stacer
  install_steam
  install_telegram
  install_spotify
  install_discord
  install_vscode
  install_firacode
  
  configure_zsh
  configure_local_time
  configure_git
  create_projects_folder

  echo "\nFinished!"
}

setup
