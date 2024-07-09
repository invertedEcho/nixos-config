{ config, pkgs, ... }:

{
  home = {
    username = "echo";
    homeDirectory = "/home/echo";
    stateVersion = "23.11";

    packages = [ pkgs.fishPlugins.tide ];

    sessionVariables = {
      EDITOR = "nvim";
      FLAKE = "/home/echo/dev/priv/dotfiles/nixos";
    };

    shellAliases = {
      n = "nvim";
      lg = "lazygit";
    };

    pointerCursor = {
	gtk.enable = true;
	package = pkgs.bibata-cursors;
	name = "Bibata-Modern-Classic";
	size = 20;
    };
 #    xdg.desktopEntries = {
 #      obsidian = {
	# name = "Firefox";
	# genericName = "Note taking app";
	# exec = "appimage-run ~/.local/bin/Obsidian-1.6.3.AppImage";
	# terminal = false;
 #      };
 #    };
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.orchis-theme;
      name = "Orchis-Dark";
    };

    iconTheme = {
      package = pkgs.tela-icon-theme;
      name = "Tela";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };

  programs = {
    git = {
      enable = true;
      userName = "Jakob Stechow";
      userEmail = "jakob.stechow@pm.me";
      signing = {
	key = null;
	signByDefault = true;
      };
    };

    fish = {
      enable = true;
      # Disable fish greeting
      interactiveShellInit = ''
                set fish_greeting
        	set -l nix_shell_info (
        	  if test -n "$IN_NIX_SHELL"
        	    echo -n "<nix-shell> "
        	  end
        	)
      '';
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    home-manager.enable = true;
  };
}
