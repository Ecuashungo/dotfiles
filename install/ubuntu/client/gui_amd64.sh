#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

readonly PACKAGES_GUI_AMD64=(
    speedcrunch
    flameshot
    vlc
    libfuse2  # Required for AppImage
)

function install_code() {
    # Using snap for VSCode on x86/amd64 architecture
    echo "Installing Visual Studio Code via snap..."
    sudo snap install --classic code
}

function install_cursor() {
    # Set download and installation directories
    # Updated URL for x86_64/amd64 architecture
    APPIMAGE_URL="https://downloader.cursor.sh/linux/appImage/x64"
    ICON_URL="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDd_RXFYPQ5cmgk1d9vZa39HbbvN5oV519JA&s"
    DOWNLOAD_DIR="$HOME/Downloads"
    APP_DIR="$HOME/Applications"
    DESKTOP_ENTRY_DIR="$HOME/.local/share/applications"

    # Create necessary directories if they don't exist
    mkdir -p "$DOWNLOAD_DIR" "$APP_DIR" "$DESKTOP_ENTRY_DIR"

    # Download the Cursor AppImage
    echo "Downloading Cursor AppImage for x86_64 architecture..."
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
    sudo apt install -y "${PACKAGES_GUI_AMD64[@]}"
    install_cursor
    install_code
}

function uninstall_gui() {
    sudo apt remove -y "${PACKAGES_GUI_AMD64[@]}"
}

function main() {
    install_gui
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi