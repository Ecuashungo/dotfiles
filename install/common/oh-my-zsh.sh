#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

readonly ZSH="${HOME%/}/.oh-my-zsh"
readonly ZSH_CUSTOM="${ZSH%/}/custom"

function is_oh_my_zsh_installed() {
    if [ -d "$ZSH" ] && [ -f "$ZSH/oh-my-zsh.sh" ]; then
        return 0
    else
        return 1
    fi
}

function install_oh_my_zsh() {
    sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" "" --unattended --keep-zshrc
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $ZSH_CUSTOM/plugins/you-should-use
    git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
    git clone https://github.com/fdellwing/zsh-bat.git $ZSH_CUSTOM/plugins/zsh-bat

}

function uninstall_oh_my_zsh() {
    # execute the uninstall script found at $ZSH/tools/uninstall.sh
    "${ZSH}/tools/uninstall.sh"
}

function main() {
    if is_oh_my_zsh_installed; then
        echo "Oh My Zsh is already installed"
    else
        echo "Installing Oh My Zsh..."
        install_oh_my_zsh
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi