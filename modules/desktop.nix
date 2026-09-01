{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  services.greetd = {
    enable = true;

    settings = {
      initial_session = {
        command = "start-hyprland > /dev/null 2>&1";
        user = "kitsu";
      };

      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd start-hyprland";
        user = "greeter";
      };
    };
  };

  services.udisks2.enable = true;

  systemd.services.greetd.after = [ "home-manager-kitsu.service" ];
  systemd.services.greetd.requires = [ "home-manager-kitsu.service" ];
}
