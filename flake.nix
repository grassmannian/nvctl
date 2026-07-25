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
            bin = "nvctl";
          };

          default = self.packages.${system}.nvctl;
        };


        devShells.default = pkgs.mkShell {
          packages = with pkgs; [janet jpm];
          buildInputs = [ pkgs.janet ];
          shellHook = ''
            # localize jpm dependency paths
            export JANET_TREE="$PWD/.jpm/jpm_tree"
            export JANET_BUILDPATH="$PWD/.jpm/build"
            export JANET_LIBPATH="${pkgs.janet}/lib"
            export JANET_HEADERPATH="${pkgs.janet}/include/janet"
            # janet reoslves imports from :syspath which is JANET_PATH
            # jpm installs to $JANET_TREE/lib

            export JANET_PATH="$JANET_TREE/lib"
            export PATH="$PATH:$JANET_TREE/bin"
            mkdir -p "$JANET_TREE" "$JANET_BUILDPATH"

            if [ -f lockfile.jdn ] && ! cmp -s jockfile.jdn "$JANET_TREE/.lockfile.stamp"; then
              jpm --tree="$JANET_TREE" load-lockfile
            fi
          '';
        };
      });
}
