#!/bin/bash

#TODO: configure GNU Stow
#Utility functions
#TODO: Add a function to install nodejs, npm, yarn, n, pnpm
#TODO: Add a function to install kubectl
#TODO: Add a function to install Haskell, stack, cabal
#TODO: Add a function to install Java, Maven, Gradle
#TODO: Add a function to install Golang
#TODO: Add a function to install Elixir, Erlang, mix
#TODO: Add a function to install Clojure, Leiningen
#TODO: Add a function to install Zig
#TODO: Add function to install fzf, bat, delta, eza 

check_package_installed_dpkg() {
	dpkg -s "$1" &>/dev/null
}

install_apt_package() {
	sudo apt update
	sudo apt install -y "$1"
}

install_snap_package() {
	sudo snap install --beta "$1" --classic
}

#install basic tools
install_git() {
	if ! check_package_installed_dpkg git; then
		echo "Git is not installed. Installing..."
		install_apt_package git
	else
		echo "Git is already installed."
	fi
}

install_curl() {
	if ! check_package_installed_dpkg curl; then
		echo "Curl is not installed. Installing..."
		install_apt_package curl
	else
		echo "Curl is already installed."
	fi
}

install_ripgrep() {
	if ! check_package_installed_dpkg ripgrep; then
		echo "Ripgrep is not installed. Installing..."
		install_apt_package ripgrep
	else
		echo "Ripgrep is already installed."
	fi
}

install_neofetch() {
	if ! check_package_installed_dpkg neofetch; then
		echo "Neofetch is not installed. Installing..."
		install_apt_package neofetch
	else
		echo "Neofetch is already installed."
	fi
}

install_neovim() {
	if ! check_package_installed_dpkg nvim; then
		echo "Neovim is not installed. Installing..."
		install_snap_package nvim
	else
		echo "Neovim is already installed."
	fi
}

install_tmux() {
	if ! check_package_installed_dpkg tmux; then
		echo "Tmux is not installed. Installing..."
		install_apt_package tmux
		echo "Installing tmux package manager"
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	else
		echo "Tmux is already installed."
	fi
}

install_zsh() {
	if ! check_package_installed_dpkg zsh; then
		echo "Zsh is not installed. Installing..."
		install_apt_package zsh
		sudo usermod -s /usr/bin/zsh $(whoami)
	else
		echo "Zsh is already installed."
	fi
}

install_docker() {

	if ! check_package_installed_dpkg docker-ce; then

		sudo apt-get update
		sudo apt-get install ca-certificates curl
		sudo install -m 0755 -d /etc/apt/keyrings
		sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
		sudo chmod a+r /etc/apt/keyrings/docker.asc

		# Add the repository to Apt sources:
		echo \
			"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
			sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
		sudo apt-get update

		sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
	fi
}

install_lazygit() {
	local LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')

	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"

	tar xf lazygit.tar.gz lazygit

	sudo install lazygit /usr/local/bin

	rm lazygit.tar.gz lazygit
}

install_lazydocker() {
	DIR="${DIR:-"$HOME/.local/bin"}"

	ARCH=$(uname -m)
	case $ARCH in
	i386 | i686) ARCH=x86 ;;
	armv6*) ARCH=armv6 ;;
	armv7*) ARCH=armv7 ;;
	aarch64*) ARCH=arm64 ;;
	esac

	GITHUB_LATEST_VERSION=$(curl -L -s -H 'Accept: application/json' https://github.com/jesseduffield/lazydocker/releases/latest | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')
	GITHUB_FILE="lazydocker_${GITHUB_LATEST_VERSION//v/}_$(uname -s)_${ARCH}.tar.gz"
	GITHUB_URL="https://github.com/jesseduffield/lazydocker/releases/download/${GITHUB_LATEST_VERSION}/${GITHUB_FILE}"

	curl -L -o lazydocker.tar.gz $GITHUB_URL
	tar xzvf lazydocker.tar.gz lazydocker
	install -Dm 755 lazydocker -t "$DIR"
	rm lazydocker lazydocker.tar.gz
}

#install programming languages and its tools
install_python3() {
	if ! check_package_installed_dpkg python3; then
		echo "Python 3 is not installed. Installing..."
		install_apt_package python3
	else
		echo "Python 3 is already installed."
	fi
}

install_rust() {
	if ! rustup -v; then
		echo "Rust is not installed. Installing..."
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	else
		echo "Rust is already installed."
	fi
}

echo "Installing dependencies..."
install_git
install_curl
install_ripgrep
install_neofetch
install_neovim
install_zsh

echo "Installing languages"
install_python3
install_rust

#configuring development environment

configure_git() {
	git config --global user.email $1
	git config --global user.name $2
}

add_zsh_syntax_highlighting() {
	if [ ! -d "$HOME/.zsh-syntax-highlighting" ]; then
		sudo apt install zsh-syntax-highlighting
		git clone https://github.com/catppuccin/zsh-syntax-highlighting.git
		cd zsh-syntax-highlighting/themes/
		cp -v catppuccin_mocha-zsh-syntax-highlighting.zsh ~/.zsh/
		cd -
	fi
}

install_fonts() {
	if [ ! -d "$HOME/.fonts" ]; then
		local url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip"
		local install_dir="$HOME/.fonts"

		mkdir -p "$install_dir"

		curl -L "$url" -o /tmp/JetBrainsMono.zip

    #modify this part to move all the fonts instead of just one 
		unzip -o /tmp/JetBrainsMono.zip -d /tmp

		mv /tmp/JetBrainsMonoNerdFont-ExtraLightItalic.ttf "$install_dir"
		rm /tmp
	fi
}

install_gnome_theme() {
	curl -L https://raw.githubusercontent.com/catppuccin/gnome-terminal/v0.2.0/install.py | python3 -
}

generate_ssh_key() {
	ssh-keygen -t ed25519 -C $1
	eval "$(ssh-agent -s)"
}

configure neovim() {
  if [ ! -d "$HOME/.config/nvim" ]; then
    git clone https://github.com/ViniciussSantos/nvimconfig.git ~/.config/nvim 
  fi
}

echo "Configuring development environment..."

read -p "Enter your email address for Git (will also be used for ssh key): " email
read -p "Enter your name for Git: " name

configure_git "$email" "$name"
add_zsh_syntax_highlighting
install_fonts
install_gnome_theme
generate_ssh_key "$email"
configure_neovim
