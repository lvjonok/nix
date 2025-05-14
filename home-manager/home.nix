{ config, lib, pkgs, nixgl, ... }:
{
  # imports = [
  #   ./waybar.nix
  # ];

  targets.genericLinux.enable = true;
  # targets.genericLinux = {
  #   enable = true;
  #   extraXdgDataDirs = [
  #     "/usr/share/ubuntu"
  #     "/usr/local/share/"
  #     "/usr/share/"
  #     "/var/lib/snapd/desktop"
  #   ];
  # };
  # xdg.mime.enable = true;
  xdg.systemDirs.data = [ "${config.home.homeDirectory}/.nix-profile/share/applications" ];
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

    telegram-desktop
    pavucontrol

    mako

    # Script for NVIDIA Waybar stats
    (import ./get-nvidia-stats.nix { inherit pkgs; })
  ];

  # Sway configuration management
  home.file.".config/sway/config".source = ./sway-config;
  home.file.".config/waybar/config".source = ./waybar/config.jsonc;
  home.file.".config/waybar/style.css".source = ./waybar/style.css;

  home.username = "lvjonok";
  home.homeDirectory = "/home/lvjonok";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

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

  # programs.fish = {
  #   enable       = true;          # enable Fish support
  #   #defaultShell = true;          # set Fish as your login shell
  # };

  # generate .desktop entries and drop them into your profile's share/applications
  xdg.desktopEntries = {
    "google-chrome" = {
      name        = "Google Chrome";
      exec        = "google-chrome-stable %U";
      icon        = "google-chrome";
      terminal    = false;
      type        = "Application";
      categories  = [ "Network" "WebBrowser" ];
    };
    "code" = {
      name        = "Visual Studio Code";
      exec        = "code %F";
      icon        = "code";
      terminal    = false;
      type        = "Application";
      categories  = [ "Development" "IDE" ];
    };
  };

  # # source nix.sh into your graphical session
  # home.file.".xsessionrc".text = ''
  #   if [ -e "${pkgs.nix}/etc/profile.d/nix.sh" ]; then
  #     source "${pkgs.nix}/etc/profile.d/nix.sh"
  #   fi
  # '';

  # # tell Home-Manager to extend your session PATH for GUI apps
  # home.sessionVariables = {
  #   XDG_DATA_DIRS = "$HOME/.nix-profile/share:${config.home.sessionVariables.XDG_DATA_DIRS}";
  # };

  # # ensure binaries are on PATH too
  # home.sessionPath = [ ".nix-profile/bin" ];
}
