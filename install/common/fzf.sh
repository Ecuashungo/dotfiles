#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

readonly FZF_DIR="${HOME%/}/.fzf"
readonly FZF_URL="https://github.com/junegunn/fzf.git"

function is_fzf_installed() {
    if command -v fzf &> /dev/null && [ -d "${FZF_DIR}" ]; then
        return 0
    else
        return 1
    fi
}

function clone_fzf() {
    if [ ! -d "${FZF_DIR}" ]; then
        git clone "${FZF_URL}" "${FZF_DIR}"
    fi
}

function install_fzf() {
    local install_fzf_path="${FZF_DIR%/}/install"

    "${install_fzf_path}" --bin
}

function uninstall_fzf() {
    local uninstall_fzf_path="${FZF_DIR%/}/uninstall"
    "${uninstall_fzf_path}"

    rm -rfv "${FZF_DIR}"
}

function main() {
    if is_fzf_installed; then
        echo "fzf is already installed"
    else
        echo "Installing fzf..."
        clone_fzf
        install_fzf
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi