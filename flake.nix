{
  description = "Home Manager config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    systems.url = "github:nix-systems/default-linux";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    systems,
    treefmt-nix,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    username = "jr";
    pkgs = nixpkgs.legacyPackages.${system};
    inherit (nixpkgs) lib;
    forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        }
    );
    getTreefmtEval = system: treefmt-nix.lib.evalModule pkgsFor.${system} ./lib/treefmt.nix;
  in {
    # Formatter for nix fmt
    formatter = forEachSystem (
      pkgs: (getTreefmtEval pkgs.stdenv.hostPlatform.system).config.build.wrapper
    );

    # Style check for CI
    checks = forEachSystem (pkgs: {
      style = (getTreefmtEval pkgs.stdenv.hostPlatform.system).config.build.check self;
      # no-todos = (getTreeFmtEval pkgs.stdenv.hostPlatform.system).config.checks.no-todos.check self;
    });

    # Development shell
    devShells.${system}.default = import ./lib/dev-shell.nix {inherit inputs;};

    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [./home.nix];

      extraSpecialArgs = {inherit inputs;};
    };
  };
}
