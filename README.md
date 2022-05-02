## Buildkite Units

These scripts can be used to set up some buildkite units with systemd service units. They are not too sophisticated, and could be refactored in some ways.

### Main moving parts

#### `my-buildkite-agent.nix`

This derivation creates a service unit defining how the buildkite agents should be started, and with what options.

#### `shell.nix`

This defines what agents should be declared so that they can be used in installation. This shell environment is used in the `install` script.

#### `install`

This is a bash script that will use the systemd unit defined and made available in the shell environment. Note that the agent names should be used accordingly.
