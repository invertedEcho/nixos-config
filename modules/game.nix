{pkgs, ...}: {
  hardware = {
    graphics = {
      enable = true;
    };
  };

  programs = {
    steam.enable = true;
    steam.gamescopeSession.enable = true;

    gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          renice = 10;
        };

        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    lutris
    wineWow64Packages.base
    wineWow64Packages.waylandFull
    cemu
    ryujinx
    winetricks
  ];
}
