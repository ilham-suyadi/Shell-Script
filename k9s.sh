#!/bin/bash

# Function to display an error message and exit with non-zero status
error() {
    echo "Error: $1"
    exit 1
}

# Function to install k9s for Ubuntu
install_k9s_ubuntu() {
    local version="$1"
    wget "https://github.com/derailed/k9s/releases/download/v${version}/k9s_linux_amd64.deb" || error "Failed to download k9s DEB package"
    sudo dpkg -i k9s_linux_amd64.deb || error "Failed to install k9s DEB package"
    rm k9s_linux_amd64.deb || error "Failed to remove k9s DEB package"
}

# Function to install k9s for Rocky Linux
install_k9s_rpm() {
    local version="$1"
    wget "https://github.com/derailed/k9s/releases/download/v${version}/k9s_linux_amd64.rpm" || error "Failed to download k9s RPM package"
    sudo dnf localinstall k9s_linux_amd64.rpm || error "Failed to install k9s RPM package"
    rm k9s_linux_amd64.rpm || error "Failed to remove k9s RPM package"
}

# Fetch latest version of k9s
VERSION=$(curl --silent "https://api.github.com/repos/derailed/k9s/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/') || error "Failed to fetch latest version of k9s"


if [ -f /etc/os-release ]; then
    # Extract OS ID
    OS_ID=$(grep '^ID=' /etc/os-release | cut -d '=' -f 2 | tr -d '"')
else
    echo "/etc/os-release not found"
fi

if [ "$OS_ID" == "ubuntu" ] || [ "$OS_ID" == "debian" ]; then
    install_k9s_ubuntu "$VERSION"
    unset VERSION
    exit 0
elif [ "$OS_ID" == "fedora" ] || [ "$OS_ID" == "rocky" ]; then
    install_k9s_rpm "$VERSION"
    unset VERSION
    exit 0
else
    echo "Unknow or unsupported Operating System: $OS_ID"
fi

unset VERSION
error "Unsupported operating system"