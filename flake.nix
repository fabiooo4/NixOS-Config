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

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
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
      wallpaper = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/fabiooo4/wallpapers/main/wallhaven-5w6w89.png";
        hash = "sha256-Z+CICFZSN64oIhhe66X7RlNn/gGCYAn30NLNoEHRYJY=";
      };
      profilePicture = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/fabiooo4/wallpapers/main/pfp/nika.png";
        hash = "sha256-Z+CICFZSN64oIhhe66X7RlNn/gGCYAn30NLNoEHRYJY=";
      };
      term = "kitty"; # Default terminal command
      editor = "nvim"; # Default editor
      browser = "google-chrome"; # Default browser
    };

    pkgs = nixpkgs.legacyPackages.${systemSettings.system};

    # Systems that can run tests:
    supportedSystems = ["aarch64-linux" "i686-linux" "x86_64-linux"];

    # Function to generate a set based on supported systems:
    forAllSystems = inputs.nixpkgs.lib.genAttrs supportedSystems;

    # Attribute set of nixpkgs for each system:
    nixpkgsFor =
      forAllSystems (system: import inputs.nixpkgs {inherit system;});
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
          inputs.nix-flatpak.nixosModules.nix-flatpak
          inputs.xremap-flake.nixosModules.default
          inputs.stylix.nixosModules.stylix

          ./nixos/configuration.nix
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

    # Add install script to the packages
    packages = forAllSystems (system: let
      pkgs = nixpkgsFor.${system};
    in {
      default = self.packages.${system}.install;

      install = pkgs.writeShellApplication {
        name = "install";
        runtimeInputs = with pkgs; [git nh];
        text = ''${./install.sh} "$@"'';
      };
    });

    apps = forAllSystems (system: {
      default = self.apps.${system}.install;

      install = {
        type = "app";
        program = "${self.packages.${system}.install}/bin/install";
      };
    });
  };
}
