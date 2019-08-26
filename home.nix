{ config, pkgs, ... }:

let
  powerlevel10k = import ./pkgs/powerlevel10k.nix { inherit pkgs; };
in
{
  nixpkgs.config.allowUnfree = true;

  home.packages = [
    powerlevel10k
    pkgs.awscli
    pkgs.kubernetes-helm
    pkgs.kubectl
    pkgs.kops
    pkgs.jre8
    pkgs.openjdk8
  ];

  programs.git = {
    enable = true;
    userName = "Daniel Poul Purkhus";
    userEmail = "purkhusid@gmail.com";
  };

  # programs.vscode = {
  #   enable = true;
  #   extensions = [
  #   ];
  # };

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
      # Required so that nix-darwin and custom channels are available
      export NIX_PATH="darwin-config=$HOME/.nixpkgs/darwin-configuration.nix:/nix/var/nix/profiles/per-user/root/channels:$HOME/.nix-defexpr/channels"
      
      # Theme settings
      source ${powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=23'

      #Functions

      function code {
        if [[ $# = 0 ]]
        then
            open -a "Visual Studio Code"
        else
          local argPath="$1"
          [[ $1 = /* ]] && argPath="$1" || argPath="$PWD/''${1#./}"
          open -a "Visual Studio Code" "$argPath"
        fi
      }
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "kubectl" ];
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
    secureSocket = false;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
