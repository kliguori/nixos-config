{ pkgs }:

let
  ocamlPkgs = pkgs.ocamlPackages;
in
pkgs.mkShell {
  name = "ocaml-dev";

  buildInputs = with ocamlPkgs; [
    ocaml
    utop
    dune_3
    findlib
    base
    stdio
    ppx_jane
    lwt
    lwt_ppx
    yojson
    cohttp-lwt-unix
  ];

  shellHook = ''
    export NIX_DEV_SHELL_NAME=ocaml-dev
    export SHELL=${pkgs.zsh}/bin/zsh
    exec ${pkgs.zsh}/bin/zsh --login
  '';
}