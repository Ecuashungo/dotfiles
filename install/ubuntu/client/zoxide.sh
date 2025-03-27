#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

function is_zoxide_installed() {
    if command -v zoxide &> /dev/null; then
        return 0
    else
        return 1
    fi
}

function install_zoxide() {
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
}

function uninstall_zoxide() {
    #TODO: implement this
    echo "TODO: implement this"
}

function main() {
    if is_zoxide_installed; then
        echo "zoxide is already installed"
    else
        echo "Installing zoxide..."
        install_zoxide
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi