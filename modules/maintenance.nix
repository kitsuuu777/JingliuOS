{ pkgs, ... }:

{
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  systemd.services.nixos-generation-cleanup = {
    description = "Remove old NixOS generations";

    serviceConfig = {
      Type = "oneshot";

      ExecStart =
        "${pkgs.nix}/bin/nix-env --profile /nix/var/nix/profiles/system --delete-generations +5";
    };
  };

  systemd.timers.nixos-generation-cleanup = {
    description = "Periodically remove old NixOS generations";

    wantedBy = [ "timers.target" ];

    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
  };
}
