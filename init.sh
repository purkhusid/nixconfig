# #!/usr/bin/env bash
# set -eo pipefail

# export PWD=`pwd`;

# #Accept xcode license
# if [[ $(uname) == "Darwin" ]]; then
#   sudo xcodebuild -license
# fi

# #Install Nix
# # echo "Installing Nix"
# # sh <(curl https://nixos.org/nix/install) --daemon
# # . /etc/bashrc
# # export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
# # echo "Installation of Nix successful"

# # if [[ $(uname) == "Darwin" ]]; then
# #   echo "Fixing Mac SSL issue"
# #   sleep 10
# #   sudo launchctl setenv NIX_SSL_CERT_FILE $NIX_SSL_CERT_FILE
# #   sudo launchctl kickstart -k system/org.nixos.nix-daemon
# # fi
# make install-nix

# #Install nix-darwin
# # echo "Installing nix-darwin"
# # sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.orig
# # nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
# # . ./result/bin/darwin-installer
# # . /etc/static/bashrc
# # echo "Installation of nix-darwin successful"
# make install-darwin

# #Install home-manager
# # echo "Installing home-manager"
# # nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
# # nix-channel --update
# # export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
# # nix-shell '<home-manager>' -A install
# # echo "Installation of home-manager successful"
# make install-home

# echo "Linking configs"
# if [[ $(uname) == "Darwin" ]]; then
#   mkdir -p ~/.nixpkgs
#   if [[ ! -e ~/.nixpkgs/darwin-configuration.nix ]] ; then
#     ln -s "$PWD/darwin-configuration.nix" ~/.nixpkgs/darwin-configuration.nix
#   fi

#   #Move /etc/shells if Nix is not already managing it
#   if ! grep -q "# List of shells managed by nix." "/etc/shells"; then
#     sudo mv /etc/shells /etc/shells.old
#   fi
# fi

# #Connect custom pkgs
# if [[ ! -e ~/.nixpkgs/pkgs ]] ; then
#   ln -s "$PWD/pkgs" ~/.nixpkgs/pkgs
# fi

# if [[ -z "$XDG_CONFIG_HOME" ]]; then
#   export XDG_CONFIG_HOME=~/.config
# fi

# mkdir -p "$XDG_CONFIG_HOME/nixpkgs"

# # Connect home-manager file
# if [ ! -e "$XDG_CONFIG_HOME/nixpkgs/home.nix" ] ; then
#   ln -s "$PWD/home.nix" "$XDG_CONFIG_HOME/nixpkgs/home.nix"
# fi

# # Connect Nix config file
# if [ ! -e "$XDG_CONFIG_HOME/nixpkgs/config.nix" ] ; then
#   ln -s "$PWD/config.nix" "$XDG_CONFIG_HOME/nixpkgs/config.nix"
# fi
# echo "Linking of configs successful"

# #Apply configs
# echo "Applying configs"
# darwin-rebuild switch
# home-manager switch
# echo "Configs applied"