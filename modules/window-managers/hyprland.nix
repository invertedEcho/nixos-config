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
  ];
}
