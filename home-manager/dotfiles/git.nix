{config, ...}: {
  # Gitconfig
  home.file = {
    ".gitconfig" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/.gitconfig";
    };
  };
}
