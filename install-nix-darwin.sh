#!/usr/bin/env bash
set -eo pipefail

echo "Installing nix-darwin"
if [[ -e /etc/nix/nix.conf ]]; then
  sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.before-nix-darwin  
fi

nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
. ./result/bin/darwin-installer
echo "Installation of nix-darwin successful"