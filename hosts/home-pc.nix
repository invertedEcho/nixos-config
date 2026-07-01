{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../modules/nvidia.nix
    ../modules/bluetooth.nix
  ];

  networking.hostName = "jakob-homepc";

  # Still required for android camera?
  # programs.obs-studio.enableVirtualCamera = true;

  # hopefully fixes bluetooth audio buffering
  boot.extraModprobeConfig = ''
    options btusb enable_autosuspend=n
  '';

  hardware.opentabletdriver.enable = true;

  # wake up doesnt work with nvidia
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd" "i2c-dev" "v4l2loopback"];
  hardware.i2c.enable = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };
    "/mnt/512GB_NVME" = {
      device = "/dev/disk/by-label/5125GB_NVME";
      fsType = "ntfs3";
      options = ["uid=1000" "gid=1000" "umask=0022" "nofail"];
    };
  };

  swapDevices = [];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  system.stateVersion = "25.11";
}
