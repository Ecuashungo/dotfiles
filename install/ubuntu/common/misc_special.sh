#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi


function get_arch() {
    local arch
    case "$(uname -m)" in
        x86_64) arch="amd64" ;;
        aarch64) arch="arm64" ;;
        *) echo "Unsupported architecture" && exit 1 ;;
    esac
    echo "$arch"
}

function is_git_installed() {
    if command -v git &> /dev/null; then
        return 0
    else
        return 1
    fi
}

function is_git_delta_installed() {
    if command -v delta &> /dev/null; then
        return 0
    else
        return 1
    fi
}

function is_thefuck_installed() {
    if command -v thefuck &> /dev/null; then
        return 0
    else
        return 1
    fi
}

function is_pyenv_installed() {
    if command -v pyenv &> /dev/null || [ -d "$HOME/.pyenv" ]; then
        return 0
    else
        return 1
    fi
}

function install_git() {
    sudo add-apt-repository ppa:git-core/ppa -y
    sudo apt update && sudo apt install -y git
}

function uninstall_git() {
    sudo apt-get remove -y git
}

function install_git_delta() {
    local arch
    arch=$(get_arch)
    wget -O "$HOME/Downloads/delta.deb" "https://github.com/dandavison/delta/releases/download/0.18.2/git-delta_0.18.2_${arch}.deb"
    sudo dpkg -i "$HOME/Downloads/delta.deb"
    rm "$HOME/Downloads/delta.deb"
}

function uninstall_git_delta() {
    sudo dpkg -P git-delta
}

function install_thefuck() {
    sudo apt install python3-dev python3-pip python3-setuptools
    pip3 install thefuck --user
}

function update_thefuck() {
    pip3 install thefuck --upgrade
}

function uninstall_thefuck() {
    sudo apt-get remove -y python3-dev python3-pip python3-setuptools
    pip3 uninstall thefuck --user
}

function install_pyenv() {
    curl https://pyenv.run | bash
}

function main() {
    if is_git_installed; then
        echo "Git is already installed"
    else
        echo "Installing Git..."
        install_git
    fi
    
    if is_git_delta_installed; then
        echo "Git Delta is already installed"
    else
        echo "Installing Git Delta..."
        install_git_delta
    fi
    
    if is_thefuck_installed; then
        echo "Thefuck is already installed"
    else
        echo "Installing Thefuck..."
        install_thefuck
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi