{ pkgs, ... }:

pkgs.mkShell {
  name = "pycaml";

  packages = with pkgs; [
    (python311.withPackages (ps: with ps; [
      jax
      jaxlibWithCuda
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
  ];

  shellHook = ''
    export NIX_DEV_SHELL_NAME=pycaml
    export SHELL=${pkgs.zsh}/bin/zsh
    exec ${pkgs.zsh}/bin/zsh --login
  '';
}
