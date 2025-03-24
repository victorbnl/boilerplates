{ pkgs, lib, inputs, ... }:
let
  pkgs-unstable = import inputs.nixpkgs-unstable { system = pkgs.stdenv.system; };
in
{
  languages.typst = {
    enable = true;
    package = pkgs-unstable.typst;
  };

  env.TYPST_FONT_PATHS = lib.concatStringsSep ":" [
    "${pkgs.liberation_ttf}/share/fonts/truetype"
  ];

  scripts = {
    build.exec = "typst compile --ignore-system-fonts src/main.typ output/document.pdf";
    watch.exec = "typst watch --ignore-system-fonts src/main.typ output/document.pdf";
  };
}
