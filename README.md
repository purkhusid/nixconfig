TODO: Init scripts

# My Nix Configs
This repo contains the Nix configs

## Setup
Open a fresh shell for each step
1. `make install-nix`
2. `make install-darwin`
3. `make install-home`
4. `make install-config`

### Things I can add to the config
* Add aliases from old setup
* Add a `w`(Change workspace) command to my .zshrc

### Things not configured with Nix
* (Mac) Enable control + space for selecting next input source
* (Mac) Enable control + cmd + space for selecting previous input source
* (Mac) Set the iTerm2 theme
* (Mac) Set the iTerm2 font

### Things not installed with Nix
* OneDrive

1. Install nix-darwin
2. Install home-manager
3. Move /etc/shells to /etc/shells.old
4. Move /etc/zshrc to /etc/zshrc.old
5. Create links for nix config files in this repo to correct locations