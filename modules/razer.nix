{pkgs, ...}: {
  hardware.openrazer.users = ["echo"];
  environment.systemPackages = with pkgs; [
    openrazer-daemon
  ];

  hardware.openrazer.enable = true;
}
