{
  config,
  pkgs,
  userSettings,
  ...
}: {
  # Nvim
  home.file = {
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfilesDir}/.config/nvim";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraLuaPackages = ps: [ps.magick];
    extraPackages = [pkgs.imagemagick];
  };
}
