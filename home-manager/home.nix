{
  config,
  pkgs,
  ...
}: {
  imports = [./dotfiles.nix];
  nixpkgs.config.allowUnfree = true;

  home.username = "fabibo";
  home.homeDirectory = "/home/fabibo";

  home.stateVersion = "24.11"; # Don't change

  gtk.cursorTheme = {
    package = pkgs.simp1e-cursors;
    name = "Simp1e-Adw-Dark";
    size = 24;

    x11.enable = true;
  };

  /*
     home.pointerCursor = let
    getFrom = url: hash: name: {
      gtk.enable = true;
      x11.enable = true;
      name = name;
      size = 48;
      package = pkgs.runCommand "moveUp" {} ''
        mkdir -p $out/share/icons
        ln -s ${pkgs.fetchzip {
          url = url;
          hash = hash;
        }} $out/share/icons/${name}
      '';
    };
  in
    getFrom
    "https://github.com/ful1e5/XCursor-pro/releases/download/v2.0.2/XCursor-Pro-Dark.tar.xz"
    "sha256-x1rmWRGPXshOgcxTUXbhWTQHAO/BT6XVfE8SVLNFMk4="
    "XCursor-Pro-Dark";
  */

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

    cascadia-code

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

  fonts.fontconfig.enable = true;

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

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}
