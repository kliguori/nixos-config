{ config, lib, pkgs, osConfig, ... }:

{
  home.packages = with pkgs; [
    ocaml
    ocamlfind
    dune_3
    
    ocamlPackages.base
    ocamlPackages.stdio
    ocamlPackages.ppx_jane
    
    ocamlPackages.utop
    ocamlPackages.merlin
    ocamlPackages.ocaml-lsp
    ocamlPackages.ocamlformat
  ];
}
