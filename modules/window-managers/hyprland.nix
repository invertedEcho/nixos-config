{pkgs, ...}: {
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    # enabling hyprlock also enables hypridle
    hyprlock.enable = true;
  };
  environment.systemPackages = with pkgs; [
    waybar
    rofi
    libnotify
    wl-clipboard
    swaynotificationcenter
    swaybg
    wlogout
    grim
    slurp
    wl-color-picker
    gammastep
    brightnessctl
  ];
  systemd.user.targets.hyprland-session = {
    description = "Hyprland session target";
    bindsTo = ["graphical-session.target"];
    wants = ["xdg-desktop-autostart.target"];
  };
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [xdg-desktop-portal-hyprland];
    };
  };
}
