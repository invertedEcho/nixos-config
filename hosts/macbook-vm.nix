{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [];

  boot.initrd.availableKernelModules = ["xhci_pci" "nvme" "sr_mod"];
  boot.loader.systemd-boot.enable = true;
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  virtualisation.vmware.guest.enable = true;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/92076faf-7051-41ec-88b4-f7a6f29ddb05";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/FA5A-1B9F";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
