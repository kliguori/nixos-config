{ config, lib, pkgs, osConfig, ... }:

{
  home.packages = with pkgs; [
    # Core OCaml tooling
    ocaml  # OCaml
    dune_3 # Dune build system

    # OCaml tools
    ocamlPackages.findlib      # Dynamically find ocaml packages for use in utop
    ocamlPackages.utop         # OCaml toplevel
    ocamlPackages.merlin       # Editor integration
    ocamlPackages.ocaml-lsp    # Language Server Protocol (for VS Code, Emacs, etc.)
    
    # OCaml Packages/Libraries
    ocamlPackages.base         # Jane Street's standard lib
    ocamlPackages.stdio
  ];
}
