TODO: Init scripts

# My Nix Configs
This repo contains the Nix configs

## Prerequisites
* [nix]()
   * `sh <(curl https://nixos.org/nix/install) --daemon`
   * MacOS only: `sudo launchctl setenv NIX_SSL_CERT_FILE $NIX_SSL_CERT_FILE`
   * MacOS only: `sudo launchctl kickstart -k system/org.nixos.nix-daemon`
* [home-manager](https://github.com/rycee/home-manager)
   * `nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager`
   * `nix-channel --update`
   * `export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH`
   * `nix-shell '<home-manager>' -A install`
* MacOS only: [nix-darwin](https://github.com/LnL7/nix-darwin)
   ```
   nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
   ./result/bin/darwin-installer
   ```
   
. /Users/danielpurkhus/.nix-profile/etc/profile.d/nix.sh
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH

## Setup
1. Install prerequisites
2. Clone this repo and run `init.sh`. It will symlink the config files into the right places.

## TODO

### Things I can add to the config
* Add aliases from old setup
* Add a `w`(Change workspace) command to my .zshrc

### Things not configured with Nix
* Enable control + space for selecting next input source
* Enable control + cmd + space for selecting previous input source
* Set the iTerm2 theme
* Set the iTerm2 font

### Things not installed with Nix
* OneDrive

1. Install nix-darwin
2. Install home-manager
3. Move /etc/shells to /etc/shells.old
4. Move /etc/zshrc to /etc/zshrc.old
5. Create links for nix config files in this repo to correct locations