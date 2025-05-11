{ pkgs, lib, ... }:

{
  # Enable distributed builds.
  # This uses the modern nix.settings attribute.
  nix.distributedBuilds = true;

  # SSH Configuration for Distributed Builds:
  #
  # Nix uses SSH to connect to remote builders. The user running the Nix daemon
  # on your local machine (typically 'root') must be able to SSH into the builder
  # machines.
  #
  # 1. Key-based Authentication (Recommended):
  #    - Ensure the Nix daemon user (e.g., 'root') has an SSH key pair.
  #      Generate one if needed: `sudo ssh-keygen -t ed25519`
  #    - Copy the public key to the 'authorized_keys' file on each builder
  #      for the target user (e.g., `root` or a dedicated `nix-builder` user).
  #      Example: `sudo ssh-copy-id remote-user@threadripper`
  #
  # 2. SSH Client Configuration (`~/.ssh/config`):
  #    - This is the primary way to configure SSH settings for `protocol = "ssh-ng"`.
  #    - Create/edit the `~/.ssh/config` file for the Nix daemon user (e.g., `/root/.ssh/config`).
  #    - Example entry for `threadripper`:
  #
  #      Host threadripper
  #        HostName threadripper # Or its IP address
  #        User root # Or your specific remote user for builds
  #        # IdentityFile /root/.ssh/id_threadripper_builder # If using a non-default key
  #        # IdentitiesOnly yes # Useful if you have many keys
  #
  # 3. `sshUser` in `nix.buildMachines`:
  #    - You can specify `sshUser` directly in the builder definition below if you
  #      don't want to set it in `~/.ssh/config`. If `sshUser` is not set here or
  #      in `~/.ssh/config`, Nix defaults to the current local username (which is
  #      'root' for the daemon).
  #
  # 4. `sshKey` in `nix.buildMachines`:
  #    - The `sshKey` attribute is primarily for `protocol = "ssh"` (older).
  #    - For `protocol = "ssh-ng"`, rely on `~/.ssh/config` or standard SSH agent
  #      behavior for key selection.

  # Define the build machines.
  nix.buildMachines = [
    {
      hostName = "threadripper";
      system = "x86_64-linux"; # Ensure this matches the system type of 'threadripper'
      protocol = "ssh-ng";    # Preferred for Nix 2.0+ daemons. Use "ssh" for older/generic SSH.
      maxJobs = 50;           # Max concurrent jobs on this builder.
      speedFactor = 2;        # Relative speed compared to localhost (speedFactor = 1).
      supportedFeatures = [
        "nixos-test"
        "benchmark"
        "big-parallel"
        "kvm" # Add "kvm" if the builder can run KVM VMs for NixOS tests.
      ];
      mandatoryFeatures = []; # Features a job must require to be scheduled on this machine.

      # Optional: Public host key of the builder for security.
      # Obtain from threadripper: `cat /etc/ssh/ssh_host_ed25519_key.pub` (or other key types)
      # hostKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

      # Optional: If using protocol = "ssh" and need to specify user/key:
      # sshUser = "nix-builder"; # Overrides user from ~/.ssh/config or default
      # sshKey = "/root/.ssh/id_rsa_for_threadripper"; # Path to private key on the local machine (for protocol = "ssh")
    }
    # You can add your local machine explicitly if you want to fine-tune its properties,
    # or add other remote builders.
    # {
    #   hostName = "localhost";
    #   system = pkgs.system; # Or your local system type explicitly
    #   maxJobs = lib.floor (pkgs.lib.trivial.cores * 0.8); # Example: 80% of local cores
    #   speedFactor = 1;
    #   supportedFeatures = [ "kvm" "nixos-test" "big-parallel" ];
    # }
  ];

  # Nix will attempt to connect to `threadripper` using SSH.
  # Ensure that the user running the nix-daemon on your local machine (usually root)
  # can SSH to `threadripper` (as specified by `sshUser` in the builder entry,
  # or as configured in the Nix daemon user's `~/.ssh/config`, or root by default for `ssh-ng`).
  # The `ssh-copy-id` step mentioned earlier should handle key-based authentication.
}
