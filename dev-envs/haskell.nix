{ pkgs }:

pkgs.mkShell {
  name = "haskell-dev";

  buildInputs = with pkgs; [
    haskellPackages.ghc             # GHC
    haskellPackages.cabal-install   # project-local cabal
    pkg-config                      # for native bindings
    zlib                            # common for compression
    openssl                         # for HTTPS/websockets
  ];

  shellHook = ''
    export NIX_DEV_SHELL_NAME=haskell-dev
    export SHELL=${pkgs.zsh}/bin/zsh
    exec ${pkgs.zsh}/bin/zsh --login
  '';
}
