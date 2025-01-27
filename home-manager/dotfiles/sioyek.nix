{
  config,
  userSettings,
  ...
}: {
  # Sioyek
  home.file = {
    ".config/sioyek" = {
      source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfilesDir}/.config/sioyek";
    };
  };
}
