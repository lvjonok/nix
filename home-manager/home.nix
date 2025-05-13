{ config, lib, pkgs, nixgl, ... }:
{
  imports = [
    ./waybar.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    google-chrome

    # fonts 
    nerd-fonts.space-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.dejavu-sans-mono
    noto-fonts-cjk-sans # Explicitly include for CJK support
    noto-fonts-emoji # Explicitly include for emoji support

    nerd-fonts.symbols-only # This one


    # Script for NVIDIA Waybar stats
    (import ./get-nvidia-stats.nix { inherit pkgs; })
  ];

  # Sway configuration management
  home.file.".config/sway/config".source = ./sway-config;

  home.username = "lvjonok";
  home.homeDirectory = "/home/lvjonok";
  home.stateVersion = "23.05";
  programs.home-manager.enable = true;
  programs.kitty.enable = true;

  programs.git = {
    enable = true;
    userName = "Lev Kozlov";
    userEmail = "kozlov.l.a10@gmail.com";
  };

  fonts.fontconfig.enableProfileFonts = true;

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      mkhl.direnv
      arrterian.nix-env-selector
      ms-vscode-remote.remote-ssh

      github.github-vscode-theme
    ];
    userSettings = {
      "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace', monospace";
      "editor.fontSize" = 12;
      "terminal.integrated.fontSize" = 12;
      "editor.fontLigatures" = true;
      "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace'";
      "workbench.colorTheme" = "GitHub Light";
    };
  };
}
