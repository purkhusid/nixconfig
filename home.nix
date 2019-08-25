{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.packages = [
    pkgs.zsh-powerlevel9k
    pkgs.awscli
  ];

  programs.git = {
    enable = true;
    userName = "Daniel Poul Purkhus";
    userEmail = "purkhusid@gmail.com";
  };

  programs.vscode = {
    enable = true;
    extensions = [
    ];
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    history.extended = true;
    initExtra = ''
      # Required so that Nix is available in zsh
      . $HOME/.nix-profile/etc/profile.d/nix.sh
      export NIX_PATH=$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH
      
      # Theme settings
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=23'
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "kubectl" ];
      theme = "agnoster";
      custom = "${builtins.getEnv "HOME"}/.zsh_custom";
    };
    # sessionVariables = import ./sessionVariables {
    #   inherit pkgs;
    # };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    aggressiveResize = true;
    escapeTime = 0;
    historyLimit = 200000;
    extraConfig = ''
    $HOME/.nix-profile/bin/zsh
    set-option -g default-shell /bin/zsh
    setw -g automatic-rename
    set -g mouse on
    '';
    plugins = with pkgs; [
      tmuxPlugins.yank
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = "set -g @continuum-restore 'on'";
      }
    ];
    terminal = "screen-256color";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
