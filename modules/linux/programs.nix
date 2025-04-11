{pkgs, ...}: {
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  programs = {
    ssh = {
      extraConfig = "
Host *
  IdentityAgent ~/.1password/agent.sock
Host homeserver
  HostName ssh.invertedecho.com
  ProxyCommand /run/current-system/sw/bin/cloudflared access ssh --hostname %h
	";
    };
    firefox = {
      enable = true;
      policies = {
        DisablePocket = true;
        DisplayBookmarksToolbar = "never";
        ExtensionSettings = {
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
          "{d634138d-c276-4fc8-924b-40a0ea21d284}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/1password-x-password-manager/latest.xpi";
            installation_mode = "force_installed";
          };
          "{eb8c4a94-e603-49ef-8e81-73d3c4cc04ff}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/3595905/gruvbox_dark_theme-1.1.xpi";
            installation_mode = "force_installed";
          };
          "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/file/4458679/vimium_ff-2.2.1.xpi";
            installation_mode = "force_installed";
          };
        };
      };
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };

    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    git = {
      enable = true;
      config = {push.autoSetupRemote = true;};
    };

    zsh.enable = true;

    adb.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    tmux.enable = true;
  };
}
