{ pkgs ? import <nixpkgs> {} }:

let
  qtEnv = with pkgs.qt6; env "jingliu-qt-${qtbase.version}" [
    qtdeclarative
  ];
in
pkgs.mkShell {
  packages = [
    qtEnv
    pkgs.cage
  ];
}
