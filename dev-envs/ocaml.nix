{ config, lib, pkgs, ... }:

pkgs.mkShell {
  name = "ocaml-dev";

  packages = with pkgs; [
    ocaml
    dune_3
    ocamlPackages.base
    ocamlPackages.utop
    ocamlPackages.merlin
    ocamlPackages.ocaml-lsp
  ];

  shellHook = ''
    echo "🦫 Welcome to the OCaml dev environment!"
    echo "OCaml version: $(ocaml -version)"
  '';
}
