{pkgs, ...}: {
  home.username = "jr";
  home.homeDirectory = "/home/jr";
  home.stateVersion = "26.05";

  imports = [
    ./modules/jj.nix
    # ./modules/editors/helix
  ];

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
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
  ];

  programs = {
    git.enable = true;
    yazi.enable = true;
    ghostty.enable = true;
    helix.enable = true;
  };

  # custom = {
  #   helix.enable = true;
  # };
}
