{ pkgs }:

pkgs.stdenvNoCC.mkDerivation {
  pname = "jingliu-splash";
  version = "1.0";

  src = ../assets/jingliu-splash;

  installPhase = ''
    mkdir -p $out/share/jingliu-splash
    cp -r . $out/share/jingliu-splash

    mkdir -p $out/bin

    cat > $out/bin/jingliu-splash <<EOF2
#!${pkgs.bash}/bin/bash

export QML_IMPORT_PATH=""
export QML2_IMPORT_PATH="${pkgs.qt6Packages.qtdeclarative}/lib/qt-6/qml"
export QT_QPA_PLATFORM=wayland
export QML_XHR_ALLOW_FILE_READ=1

exec ${pkgs.qt6Packages.qtdeclarative}/bin/qml \
  "$out/share/jingliu-splash/main.qml"
EOF2

    chmod +x $out/bin/jingliu-splash
  '';
}
