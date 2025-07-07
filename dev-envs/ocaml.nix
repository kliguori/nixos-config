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
  ];

    # export OCAMLPATH=$(ocamlfind printconf path)
  shellHook = ''
    echo "Starting Zsh with Starship prompt..."
    export SHELL=${pkgs.zsh}/bin/zsh
    exec ${pkgs.zsh}/bin/zsh --login
  '';
}