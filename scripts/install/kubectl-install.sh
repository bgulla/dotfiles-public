#!/bin/bash

# Ensure ~/bin exists
mkdir -p ~/bin

# Detect system architecture
ARCH="$(uname -m)"
case $ARCH in
    x86_64) ARCH="amd64" ;;
    aarch64) ARCH="arm64" ;;
    armv*) ARCH="arm" ;;
    *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

# Fetch latest release version of kubectl
KUBECTL_VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)

# Download the kubectl binary for the detected architecture
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_VERSION/bin/linux/$ARCH/kubectl"

# Make the binary executable
chmod +x kubectl

# Move it to ~/bin
mv kubectl ~/bin/

echo "kubectl ($KUBECTL_VERSION) installed to ~/bin"
