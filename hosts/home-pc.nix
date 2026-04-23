{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../modules/nvidia.nix
    ../modules/bluetooth.nix
  ];

  # wake up doesnt work with nvidia
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd" "i2c-dev"];
  hardware.i2c.enable = true;
  boot.extraModulePackages = [];

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
      fsType = "ntfs";
      options = ["uid=1000" "nofail"];
    };
  };

  swapDevices = [];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  system.stateVersion = "25.11";

  systemd.services.applyUserMonitorSettings = let
    username = "echo";
    gdmConfigDir = "/var/lib/gdm/seat0/config";
  in {
    description = "Apply user monitor settings to GDM login screen";
    after = ["network.target" "systemd-user-sessions.service" "display-manager.service"];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'echo \"Applying user monitor settings to GDM login screen\" && mkdir -p ${gdmConfigDir} && echo \"Created ${gdmConfigDir} directory\" && [ \"/home/${username}/.config/monitors.xml\" -ef \"${gdmConfigDir}/monitors.xml\" ] || cp /home/${username}/.config/monitors.xml ${gdmConfigDir}/monitors.xml && echo \"Copied monitors.xml to ${gdmConfigDir}/monitors.xml\" && chown gdm:gdm ${gdmConfigDir}/monitors.xml && echo \"Changed ownership of monitors.xml to gdm\"'";
    };
  };
}
