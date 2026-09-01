{ pkgs, ... }:

{
  programs.fish.enable = true;

  users.users."kitsu" = {
    isNormalUser = true;
    description = "kitsu";

    extraGroups = [
      "networkmanager"
      "wheel"
    ];

    shell = pkgs.fish;
    packages = [];
  };
}
