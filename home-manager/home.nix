{
  config,
  pkgs,
  inputs,
  userSettings,
  ...
}: let
  rebuild-script = import ../scripts/rebuild.nix {
    inherit pkgs;
    nixosDirectory = userSettings.nixosConfigDir;
  };
in {
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
    ./dotfiles
    ../modules/home-manager/gnome.nix
    ../modules/home-manager/spicetify.nix
  ];
  nixpkgs.config.allowUnfree = true;

  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;

  home.stateVersion = "24.11"; # Don't change

  # The home.packages option allows you to install Nix packages into your
  # environment
  home.packages = with pkgs; [
    # Nix management
    nh
    rebuild-script

    # CLI Tools
    git
    rustup
    zoxide
    fzf
    eza
    bat
    starship
    yazi

    # GUI Apps
    kitty
    google-chrome
    vesktop
    showtime
    qalculate-gtk
    zoom
    resources
    baobab
    neovide
    gnome-characters
    nautilus
  ];

  home.sessionVariables = {
    EDITOR = userSettings.editor;
    BROWSER = userSettings.browser;
    TERMINAL = userSettings.term;
    FLAKE = userSettings.nixosConfigDir;
  };

  # Flatpaks
  services.flatpak.packages = [
    "com.github.ahrm.sioyek"
  ];

  # Style
  stylix.enable = true;
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/fabiooo4/wallpapers/main/wallhaven-5w6w89.png";
      hash = "sha256-Z+CICFZSN64oIhhe66X7RlNn/gGCYAn30NLNoEHRYJY=";
    };
  };

  stylix.targets.neovim.enable = false;

  stylix.cursor = {
    package = userSettings.cursorPkg;
    name = userSettings.cursor;
    size = 24;
  };

  stylix.fonts = {
    monospace = {
      package = userSettings.fontPkg;
      name = userSettings.font;
    };
    serif = config.stylix.fonts.monospace;
    sansSerif = config.stylix.fonts.monospace;
  };

  stylix.iconTheme = {
    enable = true;
    package = pkgs.papirus-icon-theme;
    dark = "Papirus Dark";
    light = "Papirus Light";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}
