{
	description = "Home Manager config";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager}: 
		let 
			username = "purplepentagons";
			system = "x86_64-linux";
			stateVersion = "25.05";
			
			alib = (pkgs.lib.evalModules {
				modules = [ ./alib ];
					specialArgs = {
						inherit pkgs;
						lib = pkgs.lib;
					};
			}).config.functions;

			pkgs = import nixpkgs {
				inherit system;
			};

		in {
			homeConfigurations.purplepentagons = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;

				modules = [
					./home.nix
				];

				extraSpecialArgs = { 
					inherit username stateVersion system pkgs alib;
				};
			}; 
		}; 
}