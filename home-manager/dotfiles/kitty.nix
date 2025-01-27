{config, ...}: {
  home.file = {
    ".config/kitty" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/.config/kitty";
    };
  };
}
