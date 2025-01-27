{pkgs, ...}: {
  # Setup rustup
  home.activation.rustupDefaultChannel = ''
    run ${pkgs.rustup}/bin/rustup -q default stable
    run ${pkgs.rustup}/bin/rustup -q component add rust-analyzer
  '';
}
