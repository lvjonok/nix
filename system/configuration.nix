{ config, pkgs, inputs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix # Make sure this file exists in this directory

    ./hardware.nix
    ./network.nix
    ./locale.nix
    ./desktop.nix
    ./services.nix
    ./users.nix
    ./options.nix
    ./distributed-build.nix
  ];

  # Basic Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

  # System-wide environment variables if needed
  # environment.sessionVariables = { };
}
