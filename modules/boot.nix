{ pkgs, ... }:

{
  boot.plymouth.enable = true;

  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "quiet"
    "rd.udev.log_level=3"
    "rd.systemd.show_status=auto"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.timeout = 1;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 5;

  boot.loader.systemd-boot.extraInstallCommands = ''
    for uki in /boot/EFI/nixos/*-bzImage.efi; do
      if [ -f "$uki" ]; then
        ${pkgs.sbctl}/bin/sbctl sign "$uki"
      fi
    done
  '';
}
