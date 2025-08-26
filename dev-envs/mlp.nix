{ pkgs, ... }:

let
  py = pkgs.python312;
in {
  pkgs.mkShell {
    name = "mlp";
    packages = [
      (py.withPackages (ps: with ps; [
        numpy
        scipy
        sympy
        pandas
        scikit-learn
        torch-bin
        torchvision-bin
        jupyterlab
        matplotlib
        seaborn
        ffmpeg
        tqdm
      ]))
    ];

    shellHook = ''
      export NIX_DEV_SHELL_NAME=mlp
      export SHELL=${pkgs.zsh}/bin/zsh
      exec ${pkgs.zsh}/bin/zsh --login
    '';
  }
}
