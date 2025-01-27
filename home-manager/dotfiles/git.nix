{
  config,
  userSettings,
  ...
}: {
  # Gitconfig
  home.file = {
    ".gitconfig" = {
      source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfilesDir}/.gitconfig";
    };
  };
}
