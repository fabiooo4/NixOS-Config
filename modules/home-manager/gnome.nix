{
  pkgs,
  config,
  ...
}: rec {
  # To get these settings so that you can add them to your configuration after manually configuring them
  # `dconf dump /org/gnome/`
  # Another way to do this is to do `dconf watch /org/gnome` and then make the changes you want and then migrate them in as you see what they are.

  dconf.settings = {
    #
    # General system settings
    #

    # Screen blank
    "org/gnome/desktop/session".idle_delay = 0;

    # Multitasking
    "org/gnome/desktop/interface".enable-hot-corners = false;
    "org/gnome/mutter".edge-tiling = true;

    # Appearance
    "org/gnome/desktop/interface".accent-color = "orange";

    # Mouse and Touchpad
    "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";

    # Keyboard shortcuts
    "org/gnome/desktop/wm/keybindings" = {
      minimize = []; # Replaced by the one below
      switch-to-workspace-left = ["<Super>h"];

      screensaver = []; # Replaced by the one below
      switch-to-workspace-right = ["<Super>l"];

      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];

      move-to-workspace-1 = ["<Shift><Super>1"];
      move-to-workspace-2 = ["<Shift><Super>2"];
      move-to-workspace-3 = ["<Shift><Super>3"];
      move-to-workspace-4 = ["<Shift><Super>4"];
    };
  };

  #
  # Extensions
  #
  home.packages = with pkgs.gnomeExtensions; [
    alttab-mod
    app-hider
    appindicator
    awesome-tiles
    blur-my-shell
    burn-my-windows
    compiz-windows-effect
  ];

  dconf.settings = {
    # First we enable every extension that we installed above
    "org/gnome/shell".enabled-extensions =
      (map (extension: extension.extensionUuid) home.packages)
      # Then we add any extensions that come with gnome but aren't enabled
      ++ [
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
      ];

    # AltTab Mod
    "org/gnome/shell/extensions/altTab-mod" = {
      raise-first-instance-only = true;
      current-workspace-only-window = true;
      disable-hover-select = true;
    };

    # App Hider
    "org/gnome/shell/extensions/app-hider".hidden-apps = [
      "org.gnome.Extensions.desktop"
      "nvim.desktop"
    ];

    # App Indicator
    "org/gnome/shell/extensions/appindicator".legacy-tray-enabled = true;

    # Awesome Tiles
    "org/gnome/shell/extensions/awesome-tiles" = {
      enable-window-animation = true;
      gap-size = 0;
      gap-size-increments = 1;
      shortcut-align-window-to-center = ["<Super>c"];
      shortcut-decrease-gap-size = ["<Super>-"];
      shortcut-increase-gap-size = ["<Super>+"];
      shortcut-tile-window-to-bottom = ["<Super>dead_acute"];
      shortcut-tile-window-to-bottom-right = ["<Super>period"];
      shortcut-tile-window-to-center = ["<Super>backslash"];
      shortcut-tile-window-to-left = ["<Super>bracketleft"];
      shortcut-tile-window-to-right = ["<Super>bracketright"];
      shortcut-tile-window-to-top = ["<Super>semicolon"];
      shortcut-tile-window-to-top-right = ["<Super>slash"];
      tiling-steps-side = "0.5, 0.601, 0.4";
    };

    # Blur my Shell
    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      blur = true;
      static-blur = false;
      sigma = 0;
      brightness = 0.0;
      override-background = true;
      style-panel = 0;
      unblur-in-overview = true;
    };
    "org/gnome/shell/extensions/blur-my-shell/overview" = {
      blur = true;
      style-components = 2;
    };
    "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
      blur = true;
      sigma = 30;
      brightness = 0.0;
      style-dialogs = 3;
    };

    # Burn My Windows (also has a config file below)
    "org/gnome/shell/extensions/burn-my-windows".
      active-profile = "/home/fabio/.config/burn-my-windows/profiles/default.conf";

    # Compiz window effects
    "org/gnome/shell/extensions/com/github/hermes83/compiz-windows-effect" = {
      friction = 2.6;
      mass = 80.0;
      maximize-effect = false;
      resize-effect = true;
      speedup-factor-divider = 3.8;
      x-tiles = 16.0;
      y-tiles = 3.0;
    };
  };

  # Burn My Windows has a config file
  home.file.".config/burn-my-windows/profiles/default.conf".text = ''
    [burn-my-windows-profile]
    fire-enable-effect=false
    apparition-enable-effect=false
    doom-enable-effect=false
    broken-glass-enable-effect=false
    energize-a-enable-effect=false
    energize-b-enable-effect=false
    glide-enable-effect=false
    glitch-enable-effect=false
    hexagon-enable-effect=false
    incinerate-enable-effect=false
    matrix-enable-effect=false
    paint-brush-enable-effect=false
    pixelate-enable-effect=false
    pixel-wheel-enable-effect=false
    pixel-wipe-enable-effect=false
    portal-enable-effect=false
    snap-enable-effect=false
    trex-enable-effect=false
    tv-enable-effect=true
    tv-glitch-enable-effect=false
    wisps-enable-effect=false
    glide-animation-time=166
    tv-effect-color="${config.lib.stylix.colors.withHashtag.base00}"
    tv-animation-time=200
  '';
  # tv-effect-color="rgb(40,40,40)"
}
