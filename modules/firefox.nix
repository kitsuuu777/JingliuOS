{ pkgs, ... }:

let
  pywalfox-native = pkgs.callPackage ../packages/pywalfox-native.nix { };
in
{
  programs.firefox = {
    enable = true;

    nativeMessagingHosts.packages = [
      pywalfox-native
    ];
  };
}
