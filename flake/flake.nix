{
	description = "Home Manager config";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager }: 
		let 
			username = "purplepentagons";
			system = "x86_64-linux";
			stateVersion = "25.05";
			pkgs = nixpkgs.legacyPackages.${system};
			helpers = import ./helpers.nix;

			home = (import ./home.nix {
				inherit pkgs stateVersion system username;
			});
		in {
			homeConfigurations.purplepentagons = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;

				modules = [
					home
				];
			}; 
		}; 
 }