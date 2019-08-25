sudo rm -rf /etc/profile/nix.sh /etc/nix /nix ~root/.nix-profile ~root/.nix-defexpr ~root/.nix-channels ~/.nix-profile ~/.nix-defexpr ~/.nix-channels
rm -rf ~/.nix-*

if [[ $(uname) == "Darwin" ]]; then
  sudo launchctl unload /Library/LaunchDaemons/org.nixos.nix-daemon.plist
  sudo rm /Library/LaunchDaemons/org.nixos.nix-daemon.plist
fi

if [[ -e /etc/bashrc.backup-before-nix ]] ; then
  sudo mv /etc/bashrc /etc/bashrc.nix
  sudo mv /etc/bashrc.backup-before-nix /etc/bashrc
  sudo rm /etc/bashrc.nix
fi

if [[ -e /etc/zshrc.backup-before-nix ]] ; then
  sudo mv /etc/zshrc /etc/zshrc.nix
  sudo mv /etc/zshrc.backup-before-nix /etc/zshrc
  sudo rm /etc/zshrc.nix
fi
