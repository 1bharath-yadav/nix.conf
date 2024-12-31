{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:1bharath-yadav/nixvim";
    stylix.url = "github:danth/stylix";
    hyprland-qtutils.url = "github:hyprwm/hyprland-qtutils";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-index-database,
      hyprland-qtutils, 
      home-manager,

      ...
    }@inputs:
    let
      user="archer";
      in{

      nixosConfigurations.zero-book = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./hosts/zero-book/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
          nix-index-database.nixosModules.nix-index
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.archer = import ./hosts/zero-book/home.nix;
            home-manager.extraSpecialArgs = {
              inherit inputs self user;
            };

          }
        ];
      };
    };
}
