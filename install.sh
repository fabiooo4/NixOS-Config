#!/bin/sh
# Automated script to install my dotfiles

# Clone nix config
if [ $# -gt 0 ]; then
    SCRIPT_DIR=$1
  else
    SCRIPT_DIR=~/.config/nixconfig
fi
nix-shell -p git --command "git clone https://github.com/fabiooo4/nixos-config $SCRIPT_DIR"

# Generate hardware config for new system
sudo nixos-generate-config --show-hardware-config > $SCRIPT_DIR/nixos/hardware-configuration.nix

# Patch flake.nix with different username/name and remove email by default
sed -i "0,/fabio/s//$(whoami)/" $SCRIPT_DIR/flake.nix
sed -i "0,/Fabio/s//$(getent passwd $(whoami) | cut -d ':' -f 5 | cut -d ',' -f 1)/" $SCRIPT_DIR/flake.nix
sed -i "s+~/.config/nixconfig+$SCRIPT_DIR+g" $SCRIPT_DIR/flake.nix

# Open up editor to manually edit flake.nix before install
if [ -z "$EDITOR" ]; then
    EDITOR=nano;
fi
$EDITOR $SCRIPT_DIR/flake.nix;


# Rebuild system
nh os switch $SCRIPT_DIR -H system;

# Install and build home-manager configuration
# nix run home-manager/master --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake $SCRIPT_DIR#user;
nh home switch $SCRIPT_DIR -H user
