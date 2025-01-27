{config, ...}: {
  # Latexmkrc
  home.file = {
    ".latexmkrc" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/.latexmkrc";
    };
  };
}
