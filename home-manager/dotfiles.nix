{
  config,
  pkgs,
  lib,
  ...
}: let
  rebuild-script = import ../scripts/rebuild.nix {
    inherit pkgs;
    nixosDirectory = "${config.dotfiles}/.config/nixconfig";
  };
in {
  options = {
    dotfiles = lib.mkOption {
      type = lib.types.path;
      apply = toString;
      default = "${config.home.homeDirectory}/.dotfiles";
      example = "${config.home.homeDirectory}/.dotfiles";
      description = "Location of the dotfiles";
    };
  };
  config = {
    home.packages = [
      rebuild-script
    ];

    home.activation = {
      # Clone dotfiles repo
      cloneDotfiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
        if ! [[ -d "${config.dotfiles}" ]]; then
                 ${pkgs.git}/bin/git clone https://github.com/fabiooo4/dotfiles.git ${config.dotfiles}
                 ${pkgs.git}/bin/git clone https://github.com/fabiooo4/Neovim.git ${config.dotfiles}/.config/nvim
                 cd ${config.dotfiles}
                 ${pkgs.git}/bin/git remote remove origin
                 ${pkgs.git}/bin/git remote add origin git@github.com:fabiooo4/dotfiles.git
                 cd ${config.dotfiles}/.config/nvim
                 ${pkgs.git}/bin/git remote remove origin
                 ${pkgs.git}/bin/git remote add origin git@github.com:fabiooo4/Neovim.git
               fi
      '';
    };

    # Kitty
    home.file = {
      ".config/kitty" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/.config/kitty";
      };
    };

    # Zsh
    home.activation = {
      # Clone zplug for plugin management
      # This is needed because all the plugins are in .zshrc
      cloneZplug = lib.hm.dag.entryAfter ["writeBoundary"] ''
        if ! [[ -d "${config.home.homeDirectory}/.zplug" ]]; then
                 ${pkgs.git}/bin/git clone https://github.com/zplug/zplug ~/.zplug
               fi
      '';
    };
    home.file = {
      ".zshrc" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/.zshrc";
      };

      ".zsh" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/.zsh";
      };
    };

    # Latexmkrc
    home.file = {
      ".latexmkrc" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/.latexmkrc";
      };
    };

    # Gitconfig
    home.file = {
      ".gitconfig" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/.gitconfig";
      };
    };

    # Sioyek
    home.file = {
      ".config/sioyek" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/.config/sioyek";
      };
    };

    # Nvim
    home.file = {
      ".config/nvim" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/.config/nvim";
      };
    };

    # Starship
    home.file = {
      ".config/starship.toml" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/.config/starship.toml";
      };
    };
  };
}
