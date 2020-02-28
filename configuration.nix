# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  powerlevel10k = import ./pkgs/powerlevel10k.nix { inherit pkgs; };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Virtualbox guest additions
  virtualisation.virtualbox.guest.enable = true;

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
  # Remove fsck that runs at startup
  boot.initrd.checkJournalingFS = false;

  networking.hostName = "dannidev-nixos"; # Define your hostname.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s3.useDHCP = true;

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "Atlantic/Reykjavik";

  # Add user danielp
  users.users.danielp = {
    isNormalUser = true;
    home = "/home/danielp/";
    description = "Daniel P. Purkhus";
    extraGroups = [ "wheel" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    vim
    curl
    git
  ];

  # Enable the X11 windowing system and GNOME
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;

  # Home manager config for user danielp
  home-manager.users.danielp = {pkgs, ...}: {
    home.file = {
      # Kitty config
      ".config/kitty/kitty.conf" = { source = ./dotfiles/kitty.conf; };
    };

    home.packages = [
      powerlevel10k
      pkgs.awscli
      pkgs.kubectl
      pkgs.kops
      pkgs.jre8
      pkgs.openjdk8
      pkgs.kitty
      pkgs.firefox
      pkgs.powerline-fonts
    ];

    programs.git = {
      enable = true;
      userName = "Daniel Poul Purkhus";
      userEmail = "purkhusid@gmail.com";
    };

    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      history = {
        extended = true;
        expireDuplicatesFirst = true;
        save = 200000;
        size = 200000;
      };
      shellAliases = {
        k = "kubectl";
      };
      initExtra = ''
        # Theme settings
        source ${powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=23'
        DEFAULT_USER=danielp
        POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
        POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs kubecontext aws)
        POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
      '';
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "kubectl"
          "aws"
          "kube-ps1" 
        ];
        custom = "${builtins.getEnv "HOME"}/.zsh_custom";
      };
    };
    
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;    
    };
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

}

