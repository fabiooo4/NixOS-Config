{ config, pkgs, ... }:

{
  imports = [ ./home/dotfiles.nix ];
  home.username = "fabibo";
  home.homeDirectory = "/home/fabibo";

  home.stateVersion = "24.11"; # Don't change

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    starship
    # Neovim dependencies
    lua51Packages.lua
    luajitPackages.luarocks
    stylua
    nodePackages.prettier
    ripgrep
    gcc
    nodejs
    xclip
    fd
    unzip
    wget
    tree-sitter
    texliveFull
    gnumake
    rustup
    # --------------
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraLuaPackages = ps: [ ps.magick ];
    extraPackages = [ pkgs.imagemagick ];
  };

  # Setup rustup
  home.activation.rustupDefaultChannel = ''
    run ${pkgs.rustup}/bin/rustup default stable
    run ${pkgs.rustup}/bin/rustup component add rust-analyzer
  '';

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "google-chrome";
    TERMINAL = "kitty";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
