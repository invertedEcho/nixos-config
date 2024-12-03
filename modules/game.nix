{pkgs, ...}: {
  hardware = {
    graphics = {
      enable = true;
    };
  };

  programs = {
    steam.enable = true;
    steam.gamescopeSession.enable = true;

    gamemode.enable = true;
  };

  environment.systemPackages = with pkgs; [
    lutris
    wineWow64Packages.base
    wineWow64Packages.waylandFull
    cemu
    ryujinx
  ];
}
