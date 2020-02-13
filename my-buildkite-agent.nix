{ pkgs ? import <nixpkgs> {}
, id # string, e.g. "ichigo"
, user # string, e.g. "justin"
, buildkite-agent # string path, e.g. "/home/justin/.buildkite-agent/bin/buildkite-agent"
}:

let
  nix-init = ''. /home/${user}/.nix-profile/etc/profile.d/nix.sh'';
  buildkite-cmd = ''${buildkite-agent} start --name="${user}-${id}"'';

in
pkgs.writeTextFile
  {
    name = "buildkite-agent-${id}";
    destination = "/buildkite-agent-${id}.service";
    text = ''
      [Unit]
      Description=My Buildkite Agent

      [Service]
      Type=simple
      ExecStart=/bin/bash -c "${nix-init} && ${buildkite-cmd}"
      RestartSec=5
      Restart=on-failure
      RestartForceExitStatus=SIGPIPE
      TimeoutStartSec=10
      TimeoutStopSec=0
      KillMode=process

      [Install]
      WantedBy=default.target
    '';
  }
