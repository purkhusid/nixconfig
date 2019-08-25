#!/usr/bin/env bash
set -eo pipefail

echo "Installing Nix"
# Can't get daemon working with nix-darwin
# sh <(curl https://nixos.org/nix/install) --daemon 
curl https://nixos.org/nix/install | sh
. /etc/bashrc
echo "Installation of Nix successful"

# Required if I manage to use --daemon
# if [[ $(uname) == "Darwin" ]]; then
#   echo "Fixing Mac SSL issue"
#   sleep 10
#   sudo launchctl setenv NIX_SSL_CERT_FILE $NIX_SSL_CERT_FILE
#   sudo launchctl kickstart -k system/org.nixos.nix-daemon
# fi
