{ pkgs, inputs, ... }: # Ensure inputs is passed if home modules need it

{
  users.users.lvjonok = {
    isNormalUser = true;
    description = "Lev";
    extraGroups = [ "networkmanager" "wheel" ]; # Add other groups like 'video', 'audio' if needed
    shell = pkgs.fish; # System-level shell for the user
  };

  # Home Manager configuration for user lvjonok
  home-manager.users.lvjonok = import ../home/lvjonok/default.nix;
  # Pass flake inputs to home-manager modules
  home-manager.extraSpecialArgs = { inherit inputs pkgs; };
}
