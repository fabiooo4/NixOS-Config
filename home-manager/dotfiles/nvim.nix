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
    extraPackages = with pkgs; [
      imagemagick

      # Neovim plugin dependencies
      lua51Packages.lua
      luajitPackages.luarocks
      stylua
      nixd
      alejandra
      nodePackages.prettier
      ripgrep
      gcc
      nodejs
      xclip
      fd
      unzip
      wget
      tree-sitter
      texliveFull
      gnumake
      rustup
      # --------------
    ];
  };
}
