#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

readonly PACKAGES=(
    openssh-client
)

function is_openssh_installed() {
    dpkg -s openssh-client &> /dev/null
}


function install_openssh() {
    sudo apt-get install -y "${PACKAGES[@]}"
}

function uninstall_openssh() {
    sudo apt-get remove -y "${PACKAGES[@]}"
}

function main() {

    if is_openssh_installed; then
        echo "OpenSSH client is already installed"
    else
        echo "Installing OpenSSH client..."
        install_openssh
    fi
}

if [ ${#BASH_SOURCE[@]} = 1 ]; then
    main
fi