{ config, lib, pkgs, osConfig, ... }:

{
  home.packages = with pkgs.ocamlPackages; [
    ocaml
    dune_3
    merlin
    ocamlfind
    ocaml-lsp
    utop
    base
    stdio
    ppx_jane
  ];
}
