{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vesktop
    grim
    slurp
    wf-recorder
    wl-clipboard
    ffmpeg
    mpv
    kdePackages.ffmpegthumbs  # miniaturki wideo w Dolphinie
    satty
    pear-desktop
    kdePackages.kconfig
  ];
}
