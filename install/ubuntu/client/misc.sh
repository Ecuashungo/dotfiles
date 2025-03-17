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

function install_misc() {
    sudo apt-get install -y "${PACKAGES_MISC[@]}"
    #sudo snap install "${PACKAGES_MISC_SNAP[@]}"
}

function uninstall_misc() {
    sudo apt-get remove -y "${PACKAGES_MISC[@]}"
    #sudo snap remove "${PACKAGES_MISC_SNAP[@]}"
}

function main() {
    install_misc
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi