{pkgs, ...}: {
  hardware = {
    graphics = {
      enable = true;
    };
  };

  programs = {
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
    cemu
    ryujinx
  ];
}
