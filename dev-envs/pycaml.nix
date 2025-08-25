{ pkgs, ... }:

pkgs.mkShell {
  name = "pycaml";

  packages = with pkgs; [
    # --- Python env ---
    (python311.withPackages (ps: with ps; [
      jax
      numpy
      pandas
      matplotlib
      seaborn
      scipy
      scikit-learn
      jupyterlab
      ipykernel
      sympy
      requests
      tqdm
    ]))

    # --- Ocaml toolchain ---
    (with ocamlPackages; [
      ocaml
      dune_3
      findlib
      utop
      odoc
      base
      core
    ])

  ];

  shellHook = ''
    export NIX_DEV_SHELL_NAME=pycaml
    export SHELL=${pkgs.zsh}/bin/zsh
    exec ${pkgs.zsh}/bin/zsh --login
  '';
}
