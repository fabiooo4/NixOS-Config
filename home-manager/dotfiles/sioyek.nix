{config, ...}: {
  # Sioyek
  home.file = {
    ".config/sioyek" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/.config/sioyek";
    };
  };
}
