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
      # input from touchpad often doesnt work after resuming from suspend-then-hibernate. https://wiki.archlinux.org/title/Touchpad_Synaptics#Touchpad_does_not_work_after_resuming_from_hibernate/suspend
      "psmouse.synaptics_intertouch=0"
    ];
    kernelModules = ["kvm-intel"];
    extraModulePackages = [];
  };

  # wakeup laptop with keyboard input. i dont know why i have to explicitly enable it. i remember tinkering around with it so i guess its my bad. but then that permament config must be somewhere else?
  services.udev.extraRules = ''
    ACTION=="add|change", SUBSYSTEM=="serio", KERNEL=="serio0", ATTR{power/wakeup}="enabled"
  '';

  # systemd.services.fix-input = {
  #   description = "Fix touchpad input after resuming from suspend-then-hibernate";
  #   after = ["suspend-then-hibernate.target"];
  #   wantedBy = ["suspend-then-hibernate.target"];
  #   serviceConfig.Type = "simple";
  #   serviceConfig.ExecStart = "modprobe -r i2c_hid_acpi && modprobe i2c_hid_acpi";
  # };

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

  services.fwupd.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  system.stateVersion = "25.11";
}
