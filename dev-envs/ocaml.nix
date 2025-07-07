{ pkgs }:

let
  ocamlPkgs = pkgs.ocamlPackages;
in
pkgs.mkShell {
  name = "ocaml";

  buildInputs = with ocamlPkgs; [
    ocaml
    utop
    dune_3
    findlib
    base
    stdio
    ppx_jane
  ];

  shellHook = ''
    export NIX_DEV_SHELL_NAME=ocaml
    export SHELL=${pkgs.zsh}/bin/zsh
    exec ${pkgs.zsh}/bin/zsh --login
  '';
}