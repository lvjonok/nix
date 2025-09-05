{
  description = "My Ubuntu Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixgl.url = "github:guibou/nixGL"; # widely used upstream
    home-manager.url = "github:nix-community/home-manager"; # master follows unstable
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = {
    nixpkgs,
    nixgl,
    home-manager,
    ...
  }: let
    # system = "aarch64-linux"; If you are running on ARM powered computer
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    homeConfigurations.lvjonok = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home-manager/home.nix ];
      extraSpecialArgs = { inherit nixgl; }; # now available inside modules
    };
  };
}
