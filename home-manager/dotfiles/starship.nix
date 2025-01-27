{
  config,
  userSettings,
  ...
}: {
  # Starship
  home.file = {
    ".config/starship.toml" = {
      source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfilesDir}/.config/starship.toml";
    };
  };
}
