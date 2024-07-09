{ pkgs, ... }:

{
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
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
  ];

}
