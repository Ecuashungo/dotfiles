#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

function is_chezmoi_installed() {
    if command -v chezmoi &> /dev/null; then
        return 0
    else
        return 1
    fi
}

function install_chezmoi() {
    sudo sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin
}

function uninstall_chezmoi() {
    sudo rm -fv /usr/local/bin/chezmoi
}

function main() {
    if is_chezmoi_installed; then
        echo "chezmoi is already installed"
    else
        echo "Installing chezmoi..."
        install_chezmoi
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi