{
  description = "System Configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:

    let 
      x86L = "x86_64-linux";
      armL = "aarch64-linux";
      armA = "aarch64-darwin";
      pkgs-x86 = import nixpkgs { system = x86L; };
    in {
      devShells.${x86L}.ocaml = import ./dev-envs/ocaml.nix { pkgs = pkgs-x86; }; # Ocaml x86 dev shell
      nixosConfigurations = {
        watson = nixpkgs.lib.nixosSystem {       # Thinkpad T14(AMD) config
          system = x86L;                         # System is x86_64 architechture
          modules = [
            ./hosts/watson/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                backupFileExtension = "backup";
                users.kevin = import ./hosts/watson/home.nix;
              };
            }
          ];
        };
      };  
    };

}
