let
  haskellNixSrc = fetchTarball {
    url = "https://github.com/input-output-hk/haskell.nix/tarball/af5998fe8d6b201d2a9be09993f1b9fae74e0082";
    sha256 = "0z5w99wkkpg2disvwjnsyp45w0bhdkrhvnrpz5nbwhhp21c71mbn";
  };
  haskellNix = import haskellNixSrc {};

  # Use this version for your project instead
  all-hies = fetchTarball {
    # Insert the desired all-hies commit here
    url = "https://github.com/infinisil/all-hies/tarball/09ba836904fa290b5e37d5403150ea0c921661fb";
    # Insert the correct hash after the first evaluation
    sha256 = "0qbjqv1fkhkx1cffqybz1mfks1jphh0vh3zd8ad2qd6lch4gyys4";
  };

  pkgs = import haskellNix.sources.nixpkgs-2003 (haskellNix.nixpkgsArgs // {
    overlays = haskellNix.nixpkgsArgs.overlays ++ [
      (import all-hies {}).overlay
    ];
  });

  set = pkgs.haskell-nix.cabalProject' {
    name = "http-api"; # relates to .cabal file
    src = pkgs.haskell-nix.haskellLib.cleanGit {
      name = "http-api";
      src = ./.;
    };
    ghc = pkgs.haskell-nix.compiler.ghc883;
    modules = [{
      # Make Cabal reinstallable
      nonReinstallablePkgs = [ "rts" "ghc-heap" "ghc-prim" "integer-gmp" "integer-simple" "base" "deepseq" "array" "ghc-boot-th" "pretty" "template-haskell" "ghcjs-prim" "ghcjs-th" "ghc-boot" "ghc" "Win32" "array" "binary" "bytestring" "containers" "directory" "filepath" "ghc-boot" "ghc-compact" "ghc-prim" "hpc" "mtl" "parsec" "process" "text" "time" "transformers" "unix" "xhtml" "terminfo" ];
    }];
  };
in set.hsPkgs.http-api.components.exes.http-api // {
  env = set.hsPkgs.shellFor {
    packages = p: [
      p.http-api
    ];
    exactDeps = true;
    tools = {
      cabal = "3.2.0.0";
      hie = "unstable";
    };
    shellHook = ''
      export HIE_HOOGLE_DATABASE=$(realpath "$(dirname "$(realpath "$(which hoogle)")")/../share/doc/hoogle/default.hoo")
    '';
  };
}
