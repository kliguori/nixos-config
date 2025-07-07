{ config, lib, pkgs, osConfig, ... }:

let
ocamlPackages = pkgs.ocamlPackages;
in {
  home.packages = with ocamlPackages; [
    ocaml
    findlib    `
    dune_3
    base
    stdio
    ppx_jane
    utop
    merlin
    ocaml-lsp
    ocamlformat
  ];
}
