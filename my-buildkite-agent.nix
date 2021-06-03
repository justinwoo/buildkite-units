{ pkgs ? import <nixpkgs> {}
, id # string, e.g. "ichigo"
, user # string, e.g. "justin"
, buildkite-agent # string path, e.g. "/home/justin/.buildkite-agent/bin/buildkite-agent"
}:

let
  nix-init = ''. /home/${user}/.nix-profile/etc/profile.d/nix.sh && . /home/${user}/.bashrc'';
  buildkite-cmd = ''${buildkite-agent} start --name="${user}-${id}" --priority=2'';

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
      Restart=always
      StartLimitInterval=0
      RestartForceExitStatus=SIGPIPE
      TimeoutStartSec=10
      TimeoutStopSec=0
      KillMode=process

      [Install]
      WantedBy=default.target
    '';
  }
