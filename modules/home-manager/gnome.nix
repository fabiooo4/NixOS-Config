{pkgs, ...}: {
  dconf.settings = {
    ## General system settings

    # Screen blank
    "org/gnome/desktop/session".idle_delay = 0;
  };
}
