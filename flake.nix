{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xremap-flake.url = "github:xremap/nix-flake";

    stylix.url = "github:danth/stylix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    systemSettings = {
      system = "x86_64-linux"; # system arch
      hostname = "nixos"; # hostname
      timezone = "Europe/Rome"; # select timezone
      locale = "en_US.UTF-8"; # select locale
    };

    userSettings = {
      username = "fabibo"; # username
      name = "Fabibo"; # name/identifier
      dotfilesDir = "/home/" + userSettings.username + "/.dotfiles"; # absolute path of the local repo
      nixosConfigDir = "/home/" + userSettings.username + "/.config/nixconfig"; # absolute path of the nix config
      font = "CaskaydiaCove Nerd Font"; # Selected font
      fontPkg = pkgs.nerd-fonts.caskaydia-cove; # Font package
      cursor = "XCursor-Pro-Dark"; # Selected cursor
      cursorPkg = pkgs.xcursor-pro; # Cursor package
      term = "kitty"; # Default terminal command
      editor = "nvim"; # Default editor
      browser = "google-chrome"; # Default browser
    };

    pkgs = nixpkgs.legacyPackages.${systemSettings.system};
  in {
    nixosConfigurations = {
      system = nixpkgs.lib.nixosSystem {
        system = systemSettings.system;
        specialArgs = {
          inherit inputs;
          inherit systemSettings;
          inherit userSettings;
        };
        modules = [
          ./nixos/configuration.nix
          # inputs.home-manager.nixosModules.default
          inputs.xremap-flake.nixosModules.default
          inputs.stylix.nixosModules.stylix
        ];
      };
    };

    homeConfigurations = {
      user = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs;
          inherit systemSettings;
          inherit userSettings;
        };
        modules = [
          inputs.stylix.homeManagerModules.stylix
          ./home-manager/home.nix
        ];
      };
    };
  };
}
