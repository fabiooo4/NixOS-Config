{config, ...}: {
  # Starship
  home.file = {
    ".config/starship.toml" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/.config/starship.toml";
    };
  };
}
