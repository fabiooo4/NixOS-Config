{
  config,
  userSettings,
  ...
}: {
  # Latexmkrc
  home.file = {
    ".latexmkrc" = {
      source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfilesDir}/.latexmkrc";
    };
  };
}
