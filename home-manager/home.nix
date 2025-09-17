{ config, lib, pkgs, nixgl, ... }:
{
  # imports = [
  #   ./waybar.nix
  # ];

  # i18n.inputMethod.enabled = "fcitx5";
  # i18n.inputMethod.fcitx5.package = pkgs.kdePackages.fcitx5-with-addons;

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
    # google-chrome
    (google-chrome.override {
      commandLineArgs = [
        "--ozone-platform=wayland"
        "--enable-features=VaapiVideoDecoder"
        "--use-gl=egl"
      ];
    })

    # fonts 
    nerd-fonts.space-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.dejavu-sans-mono
    noto-fonts-cjk-sans # Explicitly include for CJK support
    noto-fonts-emoji # Explicitly include for emoji support

    nerd-fonts.symbols-only # This one

    telegram-desktop
    pavucontrol
    slack

    mako
    gh
    logseq
    zotero
    qbittorrent
    zellij

    gcc
    stdenv.cc.cc.lib

    jetbrains.datagrip

    direnv

    # Script for NVIDIA Waybar stats
    (import ./get-nvidia-stats.nix { inherit pkgs; })

    # wine
    wineWowPackages.stable

    # kakaotalk
    (import ./kakaotalk.nix { inherit pkgs; wineprefix = "${config.home.homeDirectory}/.wine-prefix"; })

    # gifify
    gifsicle
    (import ./gifify.nix { inherit pkgs; })

    # vpn
    # hiddify-app

    # office
    libreoffice-qt
  ];

  # Wine configuration
  home.sessionVariables = {
    WINEPREFIX = "${config.home.homeDirectory}/.wine-prefix";
    LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib/";
  };

  # Create wine prefix directory
  home.file.".wine-prefix/.keep".text = "";
  
  # bluetooth control
  services.mpris-proxy.enable = true;

  # Sway configuration management
  home.file.".config/sway/config".source = ./sway-config;
  home.file.".config/sway/env".source = ./sway-env;
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

    lfs = {
      enable = true;        # Adds git-lfs and the required filter config
      # Optional: avoid fetching big LFS blobs on clone/pull; fetch on demand.
      # skipSmudge = true;
    };
  };

  fonts.fontconfig.enableProfileFonts = true;

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      mkhl.direnv
      arrterian.nix-env-selector
      ms-vscode-remote.remote-ssh

      # python
      ms-python.python
      ms-python.vscode-pylance
      # ms-toolsai.jupyter

      # useful tooling
      alefragnani.bookmarks
      twxs.cmake
      tamasfe.even-better-toml
      charliermarsh.ruff
      # wayou.vscode-todo-highlight
      gruntfuggly.todo-tree      

      # jjjermiah.pixi-vscode

      # golang
      golang.go

      # cpp
      llvm-vs-code-extensions.vscode-clangd

      # docker
      ms-vscode-remote.remote-containers
      ms-azuretools.vscode-docker

      github.github-vscode-theme
    ];
    userSettings = {
      "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace', monospace";
      "editor.fontSize" = 12;
      "terminal.integrated.fontSize" = 12;
      "editor.fontLigatures" = true;
      "terminal.integrated.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace'";
      "workbench.colorTheme" = "GitHub Light";
      # "workbench.colorTheme" = "GitHub Dark";
      "editor.minimap.enabled" = false;

      "jupyter.runInDedicatedExtensionHost" = true;
      "github.copilot.nextEditSuggestions.enabled" = true;

      # "remote.SSH.useLocalServer" = false;

      # "python.analysis.typeCheckingMode" = "basic";
    };

    # {
    #     "key": "Alt+LeftArrow",
    #     "command": "workbench.action.navigateBack",
    #     "when": "canNavigateBack"
    # }

    keybindings = [
      {
        "key" = "Alt+Left";
        "command" = "workbench.action.navigateBack";
        # "when" = "canNavigateBack";
      }
      {
        "key" = "Alt+Right";
        "command" = "workbench.action.navigateForward";
        # "when" = "canNavigateForward";
      }
    ];
  };

  # programs.fish = {
  #   enable       = true;          # enable Fish support
  #   #defaultShell = true;          # set Fish as your login shell
  # };

  # generate .desktop entries and drop them into your profile's share/applications
  xdg.desktopEntries = {
    # "google-chrome" = {
    #   name        = "Google Chrome";
    #   exec        = "google-chrome-stable %U";
    #   icon        = "google-chrome";
    #   terminal    = false;
    #   type        = "Application";
    #   categories  = [ "Network" "WebBrowser" ];
    # };
    "code" = {
      name        = "Visual Studio Code";
      exec        = "code %F";
      icon        = "code";
      terminal    = false;
      type        = "Application";
      categories  = [ "Development" "IDE" ];
    };
  };

  # programs.bash.profileExtra = lib.mkAfter ''
  #   rm -rf ${config.home.homeDirectory}/.local/share/applications/home-manager
  #   rm -rf ${config.home.homeDirectory}/.icons/nix-icons
  #   ls ${config.home.homeDirectory}/.nix-profile/share/applications/*.desktop > ${config.home.homeDirectory}/.cache/current_desktop_files.txt
  # '';
  # home.activation = {
  #   linkDesktopApplications = {
  #     after = ["writeBoundary" "createXdgUserDirectories"];
  #     before = [];
  #     data = ''
  #       rm -rf ${config.home.homeDirectory}/.local/share/applications/home-manager
  #       rm -rf ${config.home.homeDirectory}/.icons/nix-icons
  #       mkdir -p ${config.home.homeDirectory}/.local/share/applications/home-manager
  #       mkdir -p ${config.home.homeDirectory}/.icons
  #       ln -sf ${config.home.homeDirectory}/.nix-profile/share/icons ${config.home.homeDirectory}/.icons/nix-icons

  #       # Check if the cached desktop files list exists
  #       if [ -f ${config.home.homeDirectory}/.cache/current_desktop_files.txt ]; then
  #         current_files=$(cat ${config.home.homeDirectory}/.cache/current_desktop_files.txt)
  #       else
  #         current_files=""
  #       fi

  #       # Symlink new desktop entries
  #       for desktop_file in ${config.home.homeDirectory}/.nix-profile/share/applications/*.desktop; do
  #         if ! echo "$current_files" | grep -q "$(basename $desktop_file)"; then
  #           ln -sf "$desktop_file" ${config.home.homeDirectory}/.local/share/applications/home-manager/$(basename $desktop_file)
  #         fi
  #       done

  #       # Update desktop database
  #       ${pkgs.desktop-file-utils}/bin/update-desktop-database ${config.home.homeDirectory}/.local/share/applications
  #     '';
  #   };
  # };

  # # source nix.sh into your graphical session
  # home.file.".xsessionrc".text = ''
  #   if [ -e "${pkgs.nix}/etc/profile.d/nix.sh" ]; then
  #     source "${pkgs.nix}/etc/profile.d/nix.sh"
  #   fi
  # '';

  # # tell Home-Manager to extend your session PATH for GUI apps
  # home.sessionVariables = {
  #   # XDG_DATA_DIRS = "$HOME/.nix-profile/share:${config.home.sessionVariables.XDG_DATA_DIRS}";
    
  # };

  # # ensure binaries are on PATH too
  # home.sessionPath = [ ".nix-profile/bin" ];
}
