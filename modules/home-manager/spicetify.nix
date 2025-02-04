{
  pkgs,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
  ];

  # Disable auto stylix theming
  stylix.targets.spicetify.enable = false;

  programs.spicetify = {
    enable = true;
    enabledCustomApps = with spicePkgs.apps; [
      marketplace
    ];
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      hidePodcasts
      beautifulLyrics
      playNext
    ];
    theme = spicePkgs.themes.comfy;
    colorScheme = "Spotify";
  };
}
