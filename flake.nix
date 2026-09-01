{
  description = "Kitsu's JingliuOS";

  inputs = {
    nixpkgs.url = "git+https://github.com/NixOS/nixpkgs.git?ref=nixos-26.05";

    nixpkgs-unstable.url =
      "git+https://github.com/NixOS/nixpkgs.git?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    aagl,
    ...
  }: {
    nixosConfigurations.jingliuOS = nixpkgs.lib.nixosSystem {

      specialArgs = {
        inherit nixpkgs-unstable;
      };

      modules = [
        ./hosts/laptop/configuration.nix

        home-manager.nixosModules.home-manager

        {
          imports = [ aagl.nixosModules.default ];

          nix.settings = aagl.nixConfig;

          programs.honkers-railway-launcher.enable = true;
        }

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "hm-backup";

          home-manager.users.kitsu =
            import ./home/kitsu/default.nix;
        }
      ];
    };
  };
}
