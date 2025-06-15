{pkgs, ...}: {
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
  environment.defaultPackages = with pkgs; [
    waybar
    rofi
    libnotify
    wl-clipboard
    swaynotificationcenter
    swaybg
    wlogout
    grim
    slurp
    hyprlock
    wl-color-picker
    gammastep
  ];
  systemd.user.targets.hyprland-session = {
    description = "Hyprland session target";
    bindsTo = ["graphical-session.target"];
    wants = ["xdg-desktop-autostart.target"];
  };
}
