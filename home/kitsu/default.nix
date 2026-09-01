{ ... }:

{
  imports = [
    ./fish.nix
    ./kitty.nix
    ./git.nix
    ./theme.nix
  ];

  home.username = "kitsu";
  home.homeDirectory = "/home/kitsu";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  xdg.enable = true;

  home.file.".local/bin/kitty-dashboard" = {
    source = ./scripts/kitty-dashboard;
    executable = true;
  };

  xdg.configFile."hypr" = {
    source = ../../dotfiles/hypr;
    recursive = true;
  };

  xdg.configFile."noctalia" = {
    source = ../../dotfiles/noctalia;
    recursive = true;
  };
}
