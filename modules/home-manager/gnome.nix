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
  ];
  /*
     dconf.settings = {

       # First we enable every extension that we installed above
    "org/gnome/shell".enabled-extensions =
      (map (extension: extension.extensionUuid) home.packages)
      # Then we add any extensions that come with gnome but aren't enabled
      ++ [
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
      ];

  };
  */
}
