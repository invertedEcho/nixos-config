{
  lib,
  pkgs,
  ...
}: {
  networking = {
    hostName = "nixos-invertedecho";
    useDHCP = lib.mkDefault true;
    networkmanager = {
      enable = true;
      wifi.powersave = true;
    };
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
}
