{config, ...}: {
  # Nvim
  home.file = {
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/.config/nvim";
    };
  };
}
