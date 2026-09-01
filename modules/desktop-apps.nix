{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vesktop
    grim
    slurp
    wl-clipboard
    satty
    pear-desktop
    kdePackages.kconfig
  ];
}
