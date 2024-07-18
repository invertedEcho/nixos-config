{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../modules/nvidia.nix
  ];

  boot = {
    initrd.availableKernelModules =
      [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    kernelModules = [ "kvm-amd" ];
    supportedFilesystems = [ "ntfs" ];
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        theme = pkgs.sleek-grub-theme.override { withStyle = "dark"; };
      };
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/16ffa14e-4ca3-44c8-b1c3-b086a5ec27f1";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/FA09-CCA4";
      fsType = "vfat";
    };
    "/tmp" = {
      device = "tmpfs";
      fsType = "tmpfs";
      options = [ "size=8G" ];
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware = {
    cpu.amd.updateMicrocode =
      lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
