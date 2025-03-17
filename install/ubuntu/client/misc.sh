#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

readonly PACKAGES=(
    #guake
    gparted
)

readonly PACKAGES_SNAP=(
    thefuck
)

function install_misc() {
    sudo apt-get install -y "${PACKAGES[@]}"
    sudo snap install "${PACKAGES_SNAP[@]}"
}

function uninstall_misc() {
    sudo apt-get remove -y "${PACKAGES[@]}"
    sudo snap remove "${PACKAGES_SNAP[@]}"

function main() {
    install_misc
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi