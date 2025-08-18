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
      x86 = "x86_64-linux";
      aaL = "aarch64-linux";
      aaA = "aarch64-darwin";
      pkgsx86 = import nixpkgs { 
        system = "x86_64-linux"; 
        config.allowUnfree = true;
      };
    in {

      # Dev Shells
      devShells.${x86}.python-dev = import ./dev-envs/python.nix { pkgs = pkgsx86; };
      
      # Configurations
      nixosConfigurations = {
        
        # Mycroft: Dell laptop home server (Intel & Nvidia)
	      mycroft = nixpkgs.lib.nixosSystem {
	        system = x86;
	        modules = [ ./hosts/mycroft/configuration.nix ];
	      };

        # Ripper: Old Dell laptop (Intel & Nvidia)
        ripper = nixpkgs.lib.nixosSystem {
          system = x86;
          modules = [ ./hosts/ripper/configuration.nix ];
        };
        
        # Sherlock: Desktop (AMD Ryzen 9 & Nvidia RTX2080Ti)
        sherlock = nixpkgs.lib.nixosSystem {       
          system = x86;                         
          modules = [
            ./hosts/sherlock/configuration.nix
            # home-manager.nixosModules.home-manager
            # {
            #   home-manager = {
            #     useUserPackages = true;
            #     useGlobalPkgs = true;
            #     backupFileExtension = "backup";
            #     users.kevin = import ./hosts/sherlock/home.nix;
            #   };
            # }
          ];
        };

        # Watson: Thinkpad T14 (AMD)
        watson = nixpkgs.lib.nixosSystem {       
          system = x86;                         
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

        # Lestrade: Dell XPS 15 (Intel & Nvidia) 
        lestrade = nixpkgs.lib.nixosSystem {       
          system = x86;                         
          modules = [
            ./hosts/lestrade/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                backupFileExtension = "backup";
                users.kevin = import ./hosts/lestrade/home.nix;
              };
            }
          ];
        };
        
        # Mary: Custom ISO
        
      };  
    };

}
