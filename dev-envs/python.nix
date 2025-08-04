{ pkgs, ... }:

pkgs.mkShell {
  name = "python-dev";

  packages = with pkgs; [
    (python311.withPackages (ps: with ps; [
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
    export NIX_DEV_SHELL_NAME=python-dev
    export SHELL=${pkgs.zsh}/bin/zsh
    exec ${pkgs.zsh}/bin/zsh --login
  '';
}
