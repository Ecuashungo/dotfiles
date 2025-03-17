#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

readonly FONT_DIR="${HOME%/}/.local/share/fonts"
readonly NERD_FONT_ROBOTO_MONO="Roboto Mono Nerd Font Complete.ttf"
readonly NERD_FONT_HACK_MONO="Hack Regular Nerd Font Complete Mono.ttf"

function install_font() {
    local font_url="$1"
    local font_name="$2"

    mkdir -p "${FONT_DIR}"
    curl -fSL "${font_url}" -o "${FONT_DIR%/}/${font_name}"
}

function install_nerd_font_roboto_mono() {
    local font_url="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/Medium/RobotoMonoNerdFontMono-Medium.ttf"

    install_font "${font_url}" "${NERD_FONT_ROBOTO_MONO}"
}

function install_nerd_font_hack_mono() {
    local font_url="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/HackNerdFontMono-Regular.ttf"

    install_font "${font_url}" "${NERD_FONT_HACK_MONO}"
}

function install_nerd_fonts_old() {
    install_font "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf" "MesloLGS NF Regular.ttf"
    install_font "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf" "MesloLGS NF Bold.ttf"
    install_font "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf" "MesloLGS NF Italic.ttf"
    install_font "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf" "MesloLGS NF Bold Italic.ttf"
}

function uninstall_nerd_font_roboto_mono() {
    rm -fv "${FONT_DIR}/${NERD_FONT_ROBOTO_MONO}"
}

function uninstall_nerd_font_hack_mono() {
    rm -fv "${FONT_DIR}/${NERD_FONT_HACK_MONO}"
}

function main() {
    install_nerd_font_roboto_mono
    install_nerd_font_hack_mono
    install_nerd_fonts_old
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi