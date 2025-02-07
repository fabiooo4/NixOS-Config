{
  pkgs,
  lib,
  userSettings,
  ...
}: {
  imports = [
    ./kitty.nix
    ./zsh.nix
    ./latex.nix
    ./git.nix
    ./sioyek.nix
    ./nvim.nix
    ./starship.nix
    ./rust.nix
    ./xournalpp.nix
  ];

  home.activation = {
    # Clone dotfiles repo if it doesn't exist to not break symlinks
    cloneDotfiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if ! [[ -d "${userSettings.dotfilesDir}" ]]; then
               ${pkgs.git}/bin/git clone https://github.com/fabiooo4/dotfiles.git ${userSettings.dotfilesDir}
               ${pkgs.git}/bin/git clone https://github.com/fabiooo4/Neovim.git ${userSettings.dotfilesDir}/.config/nvim
               cd ${userSettings.dotfilesDir}
               ${pkgs.git}/bin/git remote remove origin
               ${pkgs.git}/bin/git remote add origin git@github.com:fabiooo4/dotfiles.git
               cd ${userSettings.dotfilesDir}/.config/nvim
               ${pkgs.git}/bin/git remote remove origin
               ${pkgs.git}/bin/git remote add origin git@github.com:fabiooo4/Neovim.git
             fi
    '';
  };
}
