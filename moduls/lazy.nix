{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # lazygit and lazydocker for terminal git and docker management, respectively
  home.packages = with pkgs; [
    lazygit
    lazydocker
  ];

  xdg.dataFile."nvim/lazy/lazy.nvim" = {
    source = pkgs.vimPlugins.lazy-nvim;
    recursive = true;
  };

  home.file.".config/nvim" = {
    source = ../config/nvim;
    recursive = true;
  };
}
