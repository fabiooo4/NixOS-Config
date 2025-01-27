{
  config,
  pkgs,
  lib,
  ...
}: {
  # Zsh
  home.activation = {
    # Clone zplug for plugin management
    # This is needed because all the plugins are in .zshrc
    cloneZplug = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if ! [[ -d "${config.home.homeDirectory}/.zplug" ]]; then
               ${pkgs.git}/bin/git clone https://github.com/zplug/zplug ~/.zplug
             fi
    '';
  };
  home.file = {
    ".zshrc" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/.zshrc";
    };

    ".zsh" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/.zsh";
    };
  };
}
