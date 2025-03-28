{ pkgs, lib, inputs, ... }:
let
  pkgs-unstable = import inputs.nixpkgs-unstable { system = pkgs.stdenv.system; };
in
{
  languages.typst = {
    enable = true;
    package = pkgs-unstable.typst;

    fontPaths = [
      "${pkgs.liberation_ttf}/share/fonts/truetype"
    ];
  };

  scripts = {
    build.exec = ''
      mkdir -p output
      typst compile --root . --ignore-system-fonts src/main.typ output/document.pdf
    '';

    watch.exec = ''
      mkdir -p output
      typst watch --root . --ignore-system-fonts src/main.typ output/document.pdf
    '';
  };

  packages = [ pkgs.typstyle ];

  git-hooks.hooks.style = {
    enable = true;
    entry = "typstyle -i";
    files = "\\.typ$";
  };
}
