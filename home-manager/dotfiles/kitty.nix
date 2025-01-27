{
  config,
  userSettings,
  ...
}: {
  home.file = {
    ".config/kitty" = {
      source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfilesDir}/.config/kitty";
    };
  };
}
