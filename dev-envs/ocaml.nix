{ pkgs }:

let
  ocamlPkgs = pkgs.ocamlPackages;
in
pkgs.mkShell {
  name = "ocaml-dev";

  buildInputs = with ocamlPkgs; [
    ocaml
    findlib
    dune_3
    base
    stdio
    ppx_jane
    utop
    merlin
    ocaml-lsp
    ocamlformat
  ];

  shellHook = ''
    export OCAMLPATH=$(ocamlfind printconf path)
    echo "Starting Zsh with Starship prompt..."
    export SHELL=${pkgs.zsh}/bin/zsh
    exec ${pkgs.zsh}/bin/zsh --login
  '';
}