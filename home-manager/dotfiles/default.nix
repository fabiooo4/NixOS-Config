{
  config,
  pkgs,
  lib,
  ...
}: let
  rebuild-script = import ../../scripts/rebuild.nix {
    inherit pkgs;
    nixosDirectory = "${config.dotfiles}/.config/nixconfig";
  };
in {
  imports = [
    ./kitty.nix
    ./zsh.nix
    ./latex.nix
    ./git.nix
    ./sioyek.nix
    ./nvim.nix
    ./starship.nix
  ];

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
      # Clone dotfiles repo if it doesn't exist to not break symlinks
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
  };
}
