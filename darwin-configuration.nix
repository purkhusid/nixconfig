{ config, pkgs, ... }:

{

  nixpkgs.overlays = [
    # macOS Applicatiions
    (import ./pkgs/apps.nix)
  ];
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    #Custom pkgs
    pkgs.Firefox
    pkgs.iTerm2

    #Standard pkgs
    pkgs.powerline-fonts
  ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.bash.enable = true;
  programs.zsh.enable = true;
  environment.shells = with pkgs; [bashInteractive zsh];
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  system.defaults = {
    NSGlobalDomain = {
      #Turn off the Press & Hold feature
      ApplePressAndHoldEnabled = false;
      # Initial delay before repeating keys
      InitialKeyRepeat = 18;
      # How fast keys are repeated
      KeyRepeat = 1;
      # Disable "natural" scroll direction
      "com.apple.swipescrolldirection" = false;
    };

    dock = {
      # Auto hide the dock
      autohide = true;
      # Disable launch animations when launching applications from the dock
      launchanim = false;
      # Set the dock to the right of the screen
      orientation = "right";
    };

    finder = {
      # Show file extensions in finder
      AppleShowAllExtensions = true;
      # Disable warning when changing file extensions
      FXEnableExtensionChangeWarning = false;
    };

    trackpad = {
      # Disable tap to click
      Clicking = false;
    };
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
    nonUS.remapTilde = true;
  };

  system.activationScripts.extraUserActivation.text = ''
  '';

  # You should generally set this to the total number of logical cores in your system.
  # $ sysctl -n hw.ncpu
  nix.maxJobs = 8;
  nix.buildCores = 8;

  fonts.enableFontDir = true;
  fonts.fonts = [
    pkgs.powerline-fonts
    pkgs.fira-code
  ];
}
