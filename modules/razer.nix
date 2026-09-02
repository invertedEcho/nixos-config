{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    openrazer-daemon
    polychromatic
  ];

  hardware.openrazer.users = ["echo"];
  hardware.openrazer.enable = true;
  hardware.openrazer.batteryNotifier = {
    frequency = 3600;
    percentage = 15;
  };
}
