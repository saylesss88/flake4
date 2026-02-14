{pkgs, inputs, ...}: {
  home.username = "jr";
  home.homeDirectory = "/home/jr";
  home.stateVersion = "26.05";

  imports = [
    ./modules/jj.nix
    ./modules/starship.nix
    ./modules/flatpak.nix
    ./modules/packages.nix
    # ./modules/editors/helix
  ];

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    kitty
    nixd
    nixfmt
    nixpkgs-review
    prettier
    prettierd
    harper
    rust-analyzer
    lldb
    taplo
    vscode-langservers-extracted
    vscode-extensions.vadimcn.vscode-lldb
    nixpkgs-fmt
    marksman
    markdown-oxide
    ltex-ls

    ripgrep
    fd
    bat
    zoxide
    eza
    starship
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww

  ];

  programs = {
    git.enable = true;
    yazi.enable = true;
    ghostty.enable = true;
    helix.enable = true;
    # zsh.enable = true;
  };

  # custom = {
  #   helix.enable = true;
  # };
}
