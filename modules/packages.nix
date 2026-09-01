{ pkgs, nixpkgs-unstable, ... }:

let
  unstable = nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    pciutils
    usbutils
    git
    curl
    nano
    htop
    btop
    unzip
    zip
    alsa-utils

    fastfetch
    kitty
    unstable.noctalia-shell
    pywalfox-native
    kdePackages.dolphin
    kdePackages.kio
    kdePackages.kio-extras
    udisks
    qalculate-qt
    qemu

    (kdePackages.qt6ct.overrideAttrs (oldAttrs: {
      patches = (oldAttrs.patches or [ ]) ++ [
        ../patches/qt6ct-0.11.patch
      ];
      pname = "qt6ct-kde";
    }))

    qt6Packages.qtstyleplugin-kvantum
  ];
}
