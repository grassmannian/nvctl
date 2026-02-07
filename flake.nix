{
  description = "nvctl, a utility for running scripts";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [ pkgs.janet pkgs.jpm ];
          shellHook = ''
            export JANET_PATH=$PWD/.jpm
            export JANET_LIBPATH=${pkgs.janet}/lib/
            export JANET_TREE=$JANET_PATH/jpm_tree
            mkdir -p "$JANET_TREE"
          '';
        };
      });
}
