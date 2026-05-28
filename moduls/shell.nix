{
  pkgs,
  email,
  name,
  privateName,
  privateEmail,
  ...
}:
{
  home.sessionVariables = {
    TERMINAL = "ghostty";
  };

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        ls = "eza -lh --group-directories-first --icons=auto";
      };
      initContent = ''
        bindkey -e
      '';
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [ "--cmd cd" ];
    };

    git = {
      enable = true;
      settings = {
        user.name = name;
        user.email = email;
        init.defaultBranch = "main";
        core.editor = "nvim";
        fetch.prune = true;
        pull.rebase = true;
        credential.helper = "cache --timeout 900";
      };
      includes = [
        {
          condition = "gitdir:~/Projects/";
          path = "~/.config/git/work.inc";
        }
        {
          condition = "gitdir:~/Private/";
          path = "~/.config/git/private.inc";
        }
      ];
    };
  };

  home.packages = with pkgs; [
    ghostty-bin

    btop
    fastfetch
    ripgrep
    eza
    fd
  ];

  xdg.configFile."ghostty/config.ghostty".text = ''
    font-family = "JetBrains Mono"
    theme = "Catppuccin Macchiato"
    confirm-close-surface = false
  '';

  home.file = {
    ".config/git/work.inc".text = ''
      [user]
        name = ${name}
        email = ${email}
      [core]
        hooksPath = ~/.config/git/hooks/work
    '';

    ".config/git/private.inc".text = ''
      [user]
        name = ${privateName}
        email = ${privateEmail}
    '';

    ".config/git/hooks/work/prepare-commit-msg" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        case "$2,$3" in
          ,)
          BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
          COMMIT_MESSAGE=$(cat "$1")
          if [[ ! $COMMIT_MESSAGE == "[$BRANCH_NAME]"* ]]; then
            echo "[$BRANCH_NAME] $COMMIT_MESSAGE" > "$1"
          fi
          ;;
          message,)
          BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
          if [[ $BRANCH_NAME != 'HEAD' ]]; then
            COMMIT_MESSAGE=$(cat "$1")
            if [[ ! $COMMIT_MESSAGE == "[$BRANCH_NAME]"* ]]; then
              echo "[$BRANCH_NAME] $COMMIT_MESSAGE" > "$1"
            fi
          fi
          ;;
          *) ;;
        esac
      '';
    };
  };
}
