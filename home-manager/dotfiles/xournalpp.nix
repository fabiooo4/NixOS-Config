{
  config,
  userSettings,
  ...
}: {
  home.file = {
    ".config/xournalpp" = {
      source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfilesDir}/.config/xournalpp";
    };
  };
}
