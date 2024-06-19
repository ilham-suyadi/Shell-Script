#!/bin/bash

error(){
	echo "Error: $1"
	exit 1
}

trivy_debian(){
    local version="$1"
    wget wget https://github.com/aquasecurity/trivy/releases/download/v${version}/trivy_${version}_Linux-64bit.deb
    dpkg -i trivy_${version}_Linux-64bit.deb || error " failed to install trivy"
    rm  trivy_${version}_Linux-64bit.deb || error "failed to remove package"
}

VERSION=$(curl --silent "https://api.github.com/repos/aquasecurity/trivy/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/') || error "Failed to fetch latest version of k9s"

if [ -f /etc/lsb-release ]; then
    trivy_debian "$VERSION"
    unset VERSION
    exit 0
fi

unset VERSION
error "Unsupported operating system"