{ justTmuxSetup, pkgs, ... }:
{
  imports =
    if justTmuxSetup then
      [
        ../moduls/tmux.nix
        ../moduls/tools.nix
        ../moduls/lazy.nix
      ]
    else
      [
        ../moduls/tools.nix
        ../moduls/shell.nix
        ../moduls/tmux.nix
        ../moduls/programs.nix
        ../moduls/lazy.nix
        ../moduls/starship.nix
        ../moduls/vscode.nix
      ];
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    targets.vscode.enable = false;
  };

  programs.zsh.initContent = ''
    export NVM_DIR="$HOME/.nvm"
      [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
      [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

    HISTFILE="$HOME/.zsh_history"
    HISTSIZE=100000
    SAVEHIST=100000
    setopt APPEND_HISTORY
    setopt INC_APPEND_HISTORY
    setopt SHARE_HISTORY

    if [[ -S "$SSH_AUTH_SOCK" ]]; then
      :
    else
      export SSH_AUTH_SOCK="$HOME/.ssh/agent"
    fi

    if command -v fd >/dev/null 2>&1; then
      export FZF_DEFAULT_COMMAND='fd --hidden --type f --strip-cwd-prefix --exclude .git --exclude node_modules --exclude Library --exclude .cache --exclude .docker --exclude .orbstack --exclude OrbStack --exclude .Trash'
      export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
      export FZF_ALT_C_COMMAND='fd --hidden --type d --strip-cwd-prefix --exclude .git --exclude node_modules --exclude Library --exclude .cache --exclude .docker --exclude .orbstack --exclude OrbStack --exclude .Trash'
    fi

    export SSH_SK_PROVIDER=/usr/local/lib/libsk-libfido2.dylib
    export PATH="$HOME/.local/bin:$PATH"

    hms() {
      if [ -z "''${1:-}" ]; then
        echo "Usage: hms <flake_ref>"
        return 1
      fi

      local flake_ref="$1"
      shift

      nix run nixpkgs#home-manager -- switch --flake "$flake_ref" --impure -b backup 
    }
  '';
}
