#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

readonly PACKAGES=(
    speedcrunch
    flameshot
    vlc
)

readonly PACKAGES_SNAP=(
    #thefuck
)

function are_gui_packages_installed() {
    local missing_packages=false
    
    for package in "${PACKAGES[@]}"; do
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

function is_vscode_installed() {
    if command -v code &> /dev/null; then
        return 0
    else
        return 1
    fi
}

function is_cursor_installed() {
    if [ -f "$HOME/Applications/cursor.AppImage" ] && [ -f "$HOME/.local/share/applications/cursor.desktop" ]; then
        return 0
    else
        return 1
    fi
}

function install_code() {
    wget -O "$HOME/Downloads/code.deb" "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-arm64"
    sudo apt install "$HOME/Downloads/code.deb"
}

function install_code_2() {
    # Download to a temporary location
    wget -O "/tmp/code.deb" "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-arm64"
    
    # Pre-configure to accept Microsoft's repository without prompting
    echo "Creating microsoft-repository accept configuration..."
    echo "vscode vscode/use_repository boolean true" | sudo debconf-set-selections
    
    # Install with -y to auto-accept and allow-downgrades to handle repository transitions
    sudo apt install -y --allow-downgrades "/tmp/code.deb"
    
    # Clean up
    rm "/tmp/code.deb"
}

function install_cursor() {
    # Ensure libfuse2 is installed (required for AppImage)    
    sudo apt install -y libfuse2

    # Set download and installation directories
    APPIMAGE_URL="https://github.com/coder/cursor-arm/releases/download/v0.44.0/cursor_0.44.0_linux_arm64.AppImage"
    ICON_URL="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDd_RXFYPQ5cmgk1d9vZa39HbbvN5oV519JA&s"
    DOWNLOAD_DIR="$HOME/Downloads"
    APP_DIR="$HOME/Applications"
    DESKTOP_ENTRY_DIR="$HOME/.local/share/applications"

    # Create necessary directories if they don't exist
    mkdir -p "$DOWNLOAD_DIR" "$APP_DIR" "$DESKTOP_ENTRY_DIR"

    # Download the Cursor AppImage
    echo "Downloading Cursor AppImage..."
    wget -O "$DOWNLOAD_DIR/cursor.AppImage" "$APPIMAGE_URL"

    # Make the AppImage executable
    echo "Setting execute permissions on the AppImage..."
    chmod +x "$DOWNLOAD_DIR/cursor.AppImage"

    # Move the AppImage to the Applications directory
    echo "Moving the AppImage to $APP_DIR..."
    mv "$DOWNLOAD_DIR/cursor.AppImage" "$APP_DIR/cursor.AppImage"

    # Download the Cursor icon
    echo "Downloading Cursor icon..."
    wget -O "$APP_DIR/cursor.png" "$ICON_URL"

    # Create a desktop entry for Cursor
    echo "Creating desktop entry..."
    cat <<EOF > "$DESKTOP_ENTRY_DIR/cursor.desktop"
[Desktop Entry]
Name=Cursor
Exec=$APP_DIR/cursor.AppImage --no-sandbox
Icon=$APP_DIR/cursor.png
Type=Application
Categories=Development;
EOF

    # Make the desktop entry executable
    chmod +x "$DESKTOP_ENTRY_DIR/cursor.desktop"

    echo "Installation complete! You can launch Cursor via the Applications menu or by running:"
    echo "\"$APP_DIR/cursor.AppImage --no-sandbox\""
}

function install_gui() {
    local packages_to_install=false
    local install_vscode=false
    local install_cursor_app=false
    
    if ! are_gui_packages_installed; then
        packages_to_install=true
    fi
    
    if ! is_vscode_installed; then
        install_vscode=true
    fi
    
    if ! is_cursor_installed; then
        install_cursor_app=true
    fi
    
    if [ "$packages_to_install" = true ]; then
        echo "Installing GUI packages..."
        sudo apt install -y "${PACKAGES[@]}"
    else
        echo "GUI packages are already installed"
    fi
    
    if [ "$install_cursor_app" = true ]; then
        echo "Installing Cursor..."
        install_cursor
    else
        echo "Cursor is already installed"
    fi
    
    if [ "$install_vscode" = true ]; then
        echo "Installing VS Code..."
        install_code_2
    else
        echo "VS Code is already installed"
    fi
}

function uninstall_gui() {
    sudo apt remove -y "${PACKAGES[@]}"
    #sudo snap remove "${PACKAGES_SNAP[@]}"
}

function main() {
    install_gui
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi