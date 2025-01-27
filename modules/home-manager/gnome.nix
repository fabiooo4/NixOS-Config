{pkgs, ...}: rec {
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
    blur-my-shell
    alttab-mod
    app-hider
    appindicator
    awesome-tiles
  ];

  dconf.settings = {
    # First we enable every extension that we installed above
    "org/gnome/shell".enabled-extensions =
      (map (extension: extension.extensionUuid) home.packages)
      # Then we add any extensions that come with gnome but aren't enabled
      ++ [
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
      ];

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
  };
}
