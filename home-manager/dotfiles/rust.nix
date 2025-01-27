{pkgs, ...}: {
  # Setup rustup
  home.activation.rustupDefaultChannel = ''
    run ${pkgs.rustup}/bin/rustup -q default stable &> /dev/null
    run ${pkgs.rustup}/bin/rustup -q component add rust-analyzer &> /dev/null
  '';
}
