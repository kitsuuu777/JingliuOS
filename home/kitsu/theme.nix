{ pkgs, ... }:

{
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.mochaSky;
    name = "catppuccin-mocha-sky-cursors";
    size = 24;

    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
  };

  qt = {
    enable = true;
    style.name = "kvantum";
  };

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };

  home.file.".config/uwsm/env".text = ''
    export XCURSOR_THEME=catppuccin-mocha-sky-cursors
    export XCURSOR_SIZE=24
    export QT_QPA_PLATFORMTHEME=qt6ct
  '';

  home.file.".config/dolphinrc".text = ''
    [UiSettings]
    ColorScheme=*
  '';
}
