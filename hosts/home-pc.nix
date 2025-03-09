{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../modules/linux/nvidia.nix
  ];

  # graphical corruption bcs nvidia after resume from suspend
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  boot = {
    kernelModules = ["kvm-amd"];
    initrd = {
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
    };
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        theme = pkgs.sleek-grub-theme.override {withStyle = "dark";};
      };
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/cd0aedc2-aa1c-4752-97bd-b57ef4ea3d55";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/4CAA-7796";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };
  };

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
