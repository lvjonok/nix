{
  description = "NixOS configuration for lvjonok-nixos";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations."lvjonok-nixos" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux"; # Adjust if your architecture is different
      specialArgs = { inherit inputs; }; # Pass flake inputs to modules
      modules = [
        ./system/configuration.nix
        home-manager.nixosModules.home-manager
      ];
    };
  };
}
