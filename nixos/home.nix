{ config, pkgs, lib, inputs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};

  fossaCursor = pkgs.stdenvNoCC.mkDerivation {
    pname = "fossa-cursors";
    version = "1.0";
    src = ./FossaCursors.tar.gz;

    installPhase = ''
      mkdir -p $out/share/icons/FossaCursors
      cp -r cursors index.theme $out/share/icons/FossaCursors/
    '';
  };
in
{
  home.username = "niliv";
  home.homeDirectory = "/home/niliv";
  home.stateVersion = "26.05";

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    package = fossaCursor;
    name = "FossaCursors";
    size = 24;
  };

  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.mangowm.hmModules.mango
    inputs.danksearch.homeModules.dsearch
    inputs.spicetify-nix.homeManagerModules.spicetify
  ];

  programs.dsearch = {
    enable = true;
    package = pkgs.dsearch;
    config = {
      listen_addr = ":43654";
      index_path = "~/.cache/danksearch/index";
      max_file_bytes = 2097152;
      worker_count = 4;
      index_all_files = true;
      auto_reindex = false;
      reindex_interval_hours = 24;
      text_extensions = [
        ".txt" ".md" ".go" ".py" ".js" ".ts" ".jsx" ".tsx"
        ".json" ".yaml" ".yml" ".toml" ".html" ".css" ".rs"
      ];
      index_paths = [
        {
          path = "~/Documents";
          max_depth = 6;
          exclude_hidden = true;
          exclude_dirs = [ "node_modules" "venv" "target" ];
        }
        {
          path = "~/Projects";
          max_depth = 8;
          exclude_hidden = true;
          exclude_dirs = [ "node_modules" ".git" "target" "dist" ];
        }
      ];
    };
  };

  programs.yazi = {
    enable = true;
    theme = lib.importTOML ../config/yazi/catppuccin-mocha-blue.toml;
  };

  programs.dank-material-shell = {
    enable = true;
    systemd = {
      enable = false;
      restartIfChanged = true;
    };
  };

  wayland.windowManager.mango = {
    enable = true;
    extraConfig = ''
      xkb_rules_layout=fr
      xkb_rules_variant=azerty

      gappih = 8
      gappiv = 8
      gappoh = 12
      gappov = 12

      borderpx = 2
      bordercolor = 0x444444ff
      focuscolor = 0xF5B6C8ff
      border_radius = 12

      new_is_master = true
      smartgaps = true

      bind=SUPER,Return,spawn,kitty
      bind=SUPER,Space,spawn,dms ipc call spotlight toggle
      bind=SUPER,N,spawn,dms ipc call notifications toggle
      bind=SUPER,L,spawn,dms ipc call lock lock
      bind=SUPER,I,spawn,zen

      bind=SUPER+ALT,1,tag,1
      bind=SUPER+ALT,2,tag,2
      bind=SUPER+ALT,3,tag,3
      bind=SUPER+ALT,4,tag,4
      bind=SUPER+ALT,5,tag,5
      bind=SUPER+ALT,6,tag,6
      bind=SUPER+ALT,7,tag,7
      bind=SUPER+ALT,8,tag,8
      bind=SUPER+ALT,9,tag,9

      bind=NONE,XF86AudioRaiseVolume,spawn,dms ipc call audio increment 5
      bind=NONE,XF86AudioLowerVolume,spawn,dms ipc call audio decrement 5
      bind=NONE,XF86AudioMute,spawn,dms ipc call audio mute
      bind=NONE,XF86MonBrightnessUp,spawn,dms ipc call brightness increment 5 ""
      bind=NONE,XF86MonBrightnessDown,spawn,dms ipc call brightness decrement 5 ""

      bind=SUPER,S,spawn,spotify
      bind=SUPER,E,spawn,kitty -e yazi
      bind=SUPER,A,killclient
      bind=SUPER,C,spawn,codium

      bind=SUPER+SHIFT,1,view,1,0
      bind=SUPER+SHIFT,2,view,2,0
      bind=SUPER+SHIFT,3,view,3,0
      bind=SUPER+SHIFT,4,view,4,0
      bind=SUPER+SHIFT,5,view,5,0
      bind=SUPER+SHIFT,6,view,6,0
      bind=SUPER+SHIFT,7,view,7,0
      bind=SUPER+SHIFT,8,view,8,0
      bind=SUPER+SHIFT,9,view,9,0

      bind=SUPER+SHIFT,Up,exchange_client,up
      bind=SUPER+SHIFT,Down,exchange_client,down
      bind=SUPER+SHIFT,Left,exchange_client,left
      bind=SUPER+SHIFT,Right,exchange_client,right

      bind=SUPER,Up,focusdir,up
      bind=SUPER,Down,focusdir,down
      bind=SUPER,Left,focusdir,left
      bind=SUPER,Right,focusdir,right

      bind=SUPER,M,spawn,dms ipc call dash toggle overview

      exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once=dms run
    '';
  };

  xdg.configFile."mango/dms/colors.conf".text = "# DMS generated colors\n";
  xdg.configFile."mango/dms/layout.conf".text = "# DMS generated layout\n";
  xdg.configFile."mango/dms/outputs.conf".text = "# DMS generated outputs\n";

  xdg.configFile."DankMaterialShell/settings.json".source = ../config/DankMaterialShell/settings.json;
  xdg.configFile."DankMaterialShell/plugin_settings.json".source = ../config/DankMaterialShell/plugin_settings.json;
  xdg.configFile."DankMaterialShell/plugins.lock.json".source = ../config/DankMaterialShell/plugins.lock.json;
  xdg.configFile."DankMaterialShell/zen.css".source = ../config/DankMaterialShell/zen.css;
  xdg.configFile."DankMaterialShell/themes/catppuccin/theme.json".source = ../config/DankMaterialShell/themes/catppuccin/theme.json;
  xdg.configFile."DankMaterialShell/themes/catppuccin/preview-dark.svg".source = ../config/DankMaterialShell/themes/catppuccin/preview-dark.svg;
  xdg.configFile."DankMaterialShell/themes/catppuccin/preview-light.svg".source = ../config/DankMaterialShell/themes/catppuccin/preview-light.svg;

  xdg.configFile."fastfetch/config.jsonc".source = ../config/fastfetch/config.jsonc;
  xdg.configFile."fastfetch/logo/catppuccin_logo.png".source = ../config/fastfetch/logo/catppuccin_logo.png;

  xdg.configFile."kitty/kitty.conf".source = ../config/kitty/kitty.conf;
  xdg.configFile."kitty/dank-theme.conf".source = ../config/kitty/dank-theme.conf;
  xdg.configFile."kitty/dank-tabs.conf".source = ../config/kitty/dank-tabs.conf;

  xdg.configFile."VSCodium/User/settings.json".source = ../config/VSCodium/User/settings.json;

  xdg.configFile."yazi/catppuccin-mocha-blue.toml".source = ../config/yazi/catppuccin-mocha-blue.toml;
  xdg.configFile."zsh/.zshrc".source = ../config/zsh/.zshrc;

  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "MangoWC";
    XDG_SESSION_DESKTOP = "mango";
    XDG_SESSION_TYPE = "wayland";
    XKB_DEFAULT_LAYOUT = "fr";
    XKB_DEFAULT_VARIANT = "azerty";
    XKB_DEFAULT_MODEL = "pc104";
    QT_QPA_PLATFORM = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };

  home.packages = with pkgs; [
    wl-clipboard
    grim
    slurp
    swaybg
  ];

  programs.home-manager.enable = true;
}
