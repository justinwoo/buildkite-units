{ pkgs ? import <nixpkgs> {} }:

let
  mkAgent = id: import ./my-buildkite-agent.nix {
    inherit id;
    buildkite-agent = "/home/justin/.buildkite-agent/bin/buildkite-agent";
    user = "justin";
  };

  ichigo = mkAgent "ichigo";
  niku = mkAgent "niku";

in
pkgs.mkShell {
  shellHook = ''
    export ichigo=${ichigo}
    export niku=${niku}
  '';
}
