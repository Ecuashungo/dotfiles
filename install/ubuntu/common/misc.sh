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
    jq  # JSON Parser
    htop
    thefuck
    #shellcheck
    unzip
    vim
    wget
    zsh
    plocate
    nmap
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