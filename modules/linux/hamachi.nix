{pkgs, ...}: {
  services = {
    logmein-hamachi.enable = true;
  };

  environment.systemPackages = with pkgs; [
    haguichi
  ];
}
