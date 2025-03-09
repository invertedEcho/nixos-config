{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../linux/modules/nvidia.nix
  ];

  boot = {
    kernelModules = ["kvm-intel"];
    extraModulePackages = [];
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
        "usb_storage"
        "usbhid"
        "sd_mod"
        "rtsx_pci_sdmmc"
      ];
      kernelModules = ["dm-snapshot"];
      luks.devices.cryptroot.device = "/dev/disk/by-uuid/4e8df990-835c-4c82-b734-76c7acbaf19c";
    };

    loader.grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      theme = pkgs.sleek-grub-theme.override {withStyle = "dark";};
    };

    binfmt.preferStaticEmulators = true;
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/d8564da3-c3e4-4c25-bcc9-5c9af9512fb3";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/B891-8ED9";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };
  };

  swapDevices = [];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
