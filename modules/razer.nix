{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    openrazer-daemon
    polychromatic
  ];

  hardware.openrazer.users = ["echo"];
  hardware.openrazer.enable = true;
}
