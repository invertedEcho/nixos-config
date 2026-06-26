{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../modules/bluetooth.nix
  ];

  networking.hostName = "jakob-thinkpad";

  boot.blacklistedKernelModules = ["mhi" "mhi_pci_generic"];

  # File systems
  fileSystems."/" = {
    device = "/dev/mapper/cryptroot";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/NIXBOOT";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  # Boot loader
  boot = {
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
      };
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod"];
      kernelModules = [];
    };
    kernelParams = [
      "resume_offset=110086144"
      "mem_sleep_default=deep"
    ];
    kernelModules = ["kvm-intel"];
    extraModulePackages = [];
  };

  # input such as touchpad often doesnt work after resuming from hibernation. this forces a reset after resume
  powerManagement.resumeCommands = ''
    modprobe -r i2c_hid_acpi && modprobe i2c_hid_acpi
  '';

  # Encryption
  boot.initrd.luks = {
    devices.cryptroot = {
      device = "/dev/nvme0n1p2";
    };
  };

  # Fingerprint support
  systemd.services.fprintd = {
    wantedBy = ["multi-user.target"];
    serviceConfig.Type = "simple";
  };
  services = {
    fprintd.enable = true;
  };

  # Swap and suspend-then-hibernate
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32 * 1024;
    }
  ];
  boot.resumeDevice = "/dev/disk/by-label/NIXROOT";
  powerManagement.enable = true;
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend-then-hibernate";
    HandlePowerKey = "hibernate";
    HandlePowerKeyLongPress = "poweroff";
  };
  services.power-profiles-daemon.enable = true;
  systemd.sleep.settings.Sleep = {
    HibernateDelaySec = "2h";
    SuspendState = "mem";
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  system.stateVersion = "25.11";
}
