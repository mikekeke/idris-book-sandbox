{
  description = "TDD with Idris sandbox";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        p = import nixpkgs { inherit system; };
        idris-book-deriv = {
          name = "idris-book-sandbox";
          src = self;
          buildInputs = [ p.idris2 p.rlwrap p.nixfmt ];
          shellHook = ''
            alias idris="rlwrap idris2"
          '';
        };
      in { devShell = p.mkShell idris-book-deriv; });
}
