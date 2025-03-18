#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

readonly PACKAGES=(
    #busybox
    curl
    cmake
    build-essential
    gpg
    git
    jq  # JSON Parser
    htop
    #shellcheck
    unzip
    vim
    wget
    zsh
    plocate
    nmap

    # Python Stuff
    python3
    python3-dev
    python3-pip
    python3-setuptools  
    python3-venv
)

function install_apt_packages() {
    sudo apt-get install -y "${PACKAGES[@]}"
}

function uninstall_apt_packages() {
    sudo apt-get remove -y "${PACKAGES[@]}"
}

function main() {
    install_apt_packages
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi