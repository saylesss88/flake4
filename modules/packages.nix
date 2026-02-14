{ inputs, pkgs, ...}: {
  home.packages = [
    inputs.rmatrix-snowfall.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.randpaper.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.slasher-horrorscripts.packages.${pkgs.stdenv.hostPlatform.system}.default
    # pkgs.swww
  ];
}
