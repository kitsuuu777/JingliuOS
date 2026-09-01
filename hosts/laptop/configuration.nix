{
  imports = [
    ./hardware-configuration.nix

    ../../modules/boot.nix
    ../../modules/system.nix
    ../../modules/networking.nix
    ../../modules/audio.nix
    ../../modules/nvidia.nix
    ../../modules/desktop.nix
    ../../modules/desktop-apps.nix
    ../../modules/firefox.nix
    ../../modules/jingliu-splash.nix
    ../../modules/gaming.nix
    ../../modules/packages.nix
    ../../modules/maintenance.nix
    ../../modules/users.nix
  ];

  networking.hostName = "nixos";

  system.stateVersion = "26.05";
}
