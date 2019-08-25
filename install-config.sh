#!/usr/bin/env bash
set -eo pipefail

export PWD=`pwd`;

echo "Linking configs"
if [[ $(uname) == "Darwin" ]]; then
  mkdir -p ~/.nixpkgs
  rm ~/.nixpkgs/darwin-configuration.nix
  ln -s "$PWD/darwin-configuration.nix" ~/.nixpkgs/darwin-configuration.nix

  #Move /etc/shells if Nix is not already managing it
  if [[ -e /etc/shells ]]; then
    if ! grep -q "# List of shells managed by nix." "/etc/shells"; then
      sudo mv /etc/shells /etc/shells.old
    fi
  fi
fi

#Connect custom pkgs
rm -rf ~/.nixpkgs/pkgs
ln -s "$PWD/pkgs" ~/.nixpkgs/pkgs

if [[ -z "$XDG_CONFIG_HOME" ]]; then
  export XDG_CONFIG_HOME=~/.config
fi

mkdir -p "$XDG_CONFIG_HOME/nixpkgs"

# Connect home-manager file
rm "$XDG_CONFIG_HOME/nixpkgs/home.nix"
ln -s "$PWD/home.nix" "$XDG_CONFIG_HOME/nixpkgs/home.nix"

# Connect Nix config file
rm "$XDG_CONFIG_HOME/nixpkgs/config.nix"
ln -s "$PWD/config.nix" "$XDG_CONFIG_HOME/nixpkgs/config.nix"
echo "Linking of configs successful"

#Apply configs
echo "Applying configs"
darwin-rebuild switch
home-manager switch
echo "Configs applied"