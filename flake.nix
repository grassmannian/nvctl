{
  description = "A client for managing user scripts";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      pkgsFor = system: nixpkgs.legacyPackages.${system};
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = pkgsFor system;
        in
        {
          default = pkgs.stdenv.mkDerivation rec {
            pname = "nv";
            version = "0.1.0";
            src = ./.;

            installPhase = ''
              mkdir -p $out/bin
              cp src/nvctl.janet $out/bin/nv
              chmod +x $out/bin/nv
              patchShebangs $out/bin
            '';
          };
        });

      devShells = forAllSystems (system:
        let
          pkgs = pkgsFor system;
        in
        {
          default = pkgs.mkShell {
            buildInputs = [ pkgs.janet ];
          };
        });
    };
}
