#!/usr/bin/env bash
set -eo pipefail

#Install Nix
echo "Installing Nix"
sh <(curl https://nixos.org/nix/install) --daemon
. /etc/bashrc
echo 'export NIX_PATH="darwin-config=$HOME/.nixpkgs/darwin-configuration.nix:/nix/var/nix/profiles/per-user/root/channels:$HOME/.nix-defexpr/channels"' > ~/.bash_profile
echo "Installation of Nix successful"

if [[ $(uname) == "Darwin" ]]; then
  echo "Fixing Mac SSL issue"
  sleep 10
  sudo launchctl setenv NIX_SSL_CERT_FILE $NIX_SSL_CERT_FILE
  sudo launchctl kickstart -k system/org.nixos.nix-daemon
fi
