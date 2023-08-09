#!/bin/bash

# Ensure ~/bin exists
mkdir -p ~/bin

# Detect system architecture
ARCH="$(uname -m)"
case $ARCH in
    x86_64) ARCH="amd64" ;;
    aarch64) ARCH="arm64" ;;
    arm64) ARCH="arm64" ;;
    *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

DISTRO=linux
if [ "$(uname)" == "Darwin" ]; then
    DISTRO="darwin"
fi


# Fetch latest release URL for Velero for the detected architecture
echo "${DISTRO}_${ARCH}.tar.gz"
VELERO_URL=$(curl -s https://api.github.com/repos/vmware-tanzu/velero/releases/latest | grep browser_download_url | grep "${DISTRO}-${ARCH}.tar.gz" | cut -d '"' -f 4)
echo ${VELERO_URL}
if [ -z "$VELERO_URL" ]; then
    echo "Couldn't fetch the binary for the detected architecture ($ARCH)."
    exit 1
fi

# Download the tar.gz file
curl -L "$VELERO_URL" -o /tmp/velero.tar.gz

# Extract the binary to ~/bin
tar -zxvf /tmp/velero.tar.gz -C /tmp/
mv /tmp/velero-v*/velero ~/bin/

# Clean up
rm -rf /tmp/velero-v*
rm /tmp/velero.tar.gz

echo "Velero installed to ~/bin"
