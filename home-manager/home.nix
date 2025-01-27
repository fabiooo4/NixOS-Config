{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./dotfiles.nix
    ../modules/home-manager/gnome.nix
  ];
  nixpkgs.config.allowUnfree = true;

  home.username = "fabibo";
  home.homeDirectory = "/home/fabibo";

  home.stateVersion = "24.11"; # Don't change

  # The home.packages option allows you to install Nix packages into your
  # environment
  home.packages = with pkgs; [
    git
    zoxide
    fzf
    eza
    bat
    starship

    sioyek
    kitty
    google-chrome

    # Neovim dependencies
    lua51Packages.lua
    luajitPackages.luarocks
    stylua
    nixd
    alejandra
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
    extraLuaPackages = ps: [ps.magick];
    extraPackages = [pkgs.imagemagick];
  };

  # Setup rustup
  home.activation.rustupDefaultChannel = ''
    run ${pkgs.rustup}/bin/rustup -q default stable
    run ${pkgs.rustup}/bin/rustup -q component add rust-analyzer
  '';

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "google-chrome";
    TERMINAL = "kitty";
  };

  # Style
  stylix.enable = true;
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    image = ../wallpaper.png;
  };

  stylix.targets.neovim.enable = false;

  stylix.cursor = {
    package = pkgs.xcursor-pro;
    name = "XCursor-Pro-Dark";
    size = 24;
  };

  stylix.fonts = {
    monospace = {
      package = pkgs.nerd-fonts.caskaydia-cove;
      name = "CaskaydiaCove Nerd Font";
    };
    serif = config.stylix.fonts.monospace;
    sansSerif = config.stylix.fonts.monospace;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}
