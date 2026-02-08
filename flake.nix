{
  description = "nvctl, a utility for running scripts";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    janet-nix = {
      url = "github:turnerdev/janet-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, janet-nix}:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        packages = {
          nvctl = janet-nix.packages.${system}.mkJanet {
            name = "nvctl";
            version = "1.0.0";
            src = ./.;
            bin = "nv";
          };
        };

        defaultPackage = self.packages.${system}.nvctl;

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [janet jpm];
          buildInputs = [ pkgs.janet ];
          shellHook = ''
            # localize jpm dependency paths
            export JANET_PATH=$PWD/.jpm
            export JANET_TREE=$JANET_PATH/jpm_tree
            export JANET_LIBPATH=${pkgs.janet}/lib/
            export JANET_HEADERPATH="${pkgs.janet}/include/janet"
            export JANET_BUILDPATH="$JANET_PATH/build"
            export PATH="$PATH:$JANET_TREE/bin"
            mkdir -p "$JANET_TREE"
            mkdir -p "$JANET_BUILDPATH"
          '';
        };
      });
}
