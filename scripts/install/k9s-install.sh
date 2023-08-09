#!/bin/bash

# Ensure ~/bin exists
mkdir -p ~/bin

# Detect system architecture
ARCH="$(uname -m)"
case $ARCH in
    x86_64) ARCH="amd64" ;;
    aarch64) ARCH="arm64" ;;
    armv*) ARCH="arm" ;;
    arm64) ARCH="arm64" ;;
    *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

# Fetch latest release URL for k9s for the detected architecture

DISTRO=Linux
if [ "$(uname)" == "Darwin" ]; then
    DISTRO="Darwin"
fi

K9S_URL=$(curl -s https://api.github.com/repos/derailed/k9s/releases/latest | grep browser_download_url | grep "${DISTRO}_$ARCH.tar.gz" | cut -d '"' -f 4)

if [ -z "$K9S_URL" ]; then
    echo "Couldn't fetch the binary for the detected architecture ($ARCH)."
    echo "${DISTRO}-$ARCH.tar.gz"
    exit 1
fi
echo "$K9S_URL"
# Download the tar.gz file
curl -L "$K9S_URL" -o /tmp/k9s.tar.gz

# Extract the binary to ~/bin
tar -zxvf /tmp/k9s.tar.gz -C /tmp/
mv /tmp/k9s ~/bin/

# Clean up
rm -rf /tmp/k9s*
rm /tmp/k9s.tar.gz

echo "k9s installed to ~/bin"
