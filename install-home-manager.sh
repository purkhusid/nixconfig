#!/usr/bin/env bash
set -eo pipefail

echo "Installing home-manager"
nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
echo "Installation of home-manager successful"