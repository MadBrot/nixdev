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

  home.packages = with pkgs; [
    home-manager
  ];

  programs.zsh.initContent = ''
    if [[ -S "$SSH_AUTH_SOCK" ]]; then
      :
    else
      export SSH_AUTH_SOCK="$HOME/.ssh/agent"
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

      home-manager switch --flake "$flake_ref" --impure -b backup 
    }
  '';
}
