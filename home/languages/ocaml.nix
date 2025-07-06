{ config, lib, pkgs, osConfig, ... }:

{
  home.packages = with pkgs; [
    # Core OCaml tooling
    ocaml
    dune_3
    findlib # to dynamically find ocaml packages for use in utop
    # opam  # will try not to use, want to manage packages with nix. 

    # OCaml libraries/tools
    ocamlPackages.base         # Jane Street's standard lib
    ocamlPackages.utop         # REPL
    ocamlPackages.merlin       # Editor integration
    ocamlPackages.ocaml-lsp    # Language Server Protocol (for VS Code, Emacs, etc.)
  ];
}
