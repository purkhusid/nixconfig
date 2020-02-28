TODO: Init scripts

# My Nix Configs
This repo contains the Nix configs

## Setup

1. Setup NixOS via live disk
2. Before running nixos-install, replace configuration.nix file with the one in this repo
3. Add home-manager channel
   `nix-channel add https://github.com/rycee/home-manager/archive/release-19.09.tar.gz home-manager`
   `nix-channel --update` 
4. Run nixos-install

