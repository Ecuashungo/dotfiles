#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

readonly PACKAGES_MISC=(
    #guake
    gparted
)

readonly PACKAGES_MISC_SNAP=(
    #thefuck
)

function are_misc_packages_installed() {
    local missing_packages=false
    
    for package in "${PACKAGES_MISC[@]}"; do
        if ! dpkg -s "$package" &> /dev/null; then
            missing_packages=true
            break
        fi
    done

    if [ "$missing_packages" = false ]; then
        return 0
    else
        return 1
    fi
}

function install_misc() {
    sudo apt-get install -y "${PACKAGES_MISC[@]}"
    #sudo snap install "${PACKAGES_MISC_SNAP[@]}"
}

function uninstall_misc() {
    sudo apt-get remove -y "${PACKAGES_MISC[@]}"
    #sudo snap remove "${PACKAGES_MISC_SNAP[@]}"
}

function main() {
    if are_misc_packages_installed; then
        echo "All misc packages are already installed"
    else
        echo "Installing misc packages..."
        install_misc
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi