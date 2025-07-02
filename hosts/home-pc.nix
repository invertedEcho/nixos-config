{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  swapDevices = lib.mkForce [];
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../modules/nvidia.nix
  ];

  # Fixes graphical corruption after resume from suspend and sddm non-functional (only cursor shown with wallpaper/clock)
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  services.teamviewer.enable = true;

  # TODO: Fix this gigantic string oneday to read from a file located in the rpeo instead,
  # but I kinda don't care, this works fine
  systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - - - - ${pkgs.writeText "gdm-monitors.xml" ''
      <monitors version="2">
        <configuration>
          <layoutmode>physical</layoutmode>
          <logicalmonitor>
            <x>3840</x>
            <y>0</y>
            <scale>1</scale>
            <monitor>
              <monitorspec>
                <connector>HDMI-1</connector>
                <vendor>SAM</vendor>
                <product>SAMSUNG</product>
                <serial>0x00000800</serial>
              </monitorspec>
              <mode>
                <width>1920</width>
                <height>1080</height>
                <rate>60.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
          <logicalmonitor>
            <x>1920</x>
            <y>0</y>
            <scale>1</scale>
            <monitor>
              <monitorspec>
                <connector>DP-3</connector>
                <vendor>DEL</vendor>
                <product>DELL U2415</product>
                <serial>7MT0177A2T2S</serial>
              </monitorspec>
              <mode>
                <width>1920</width>
                <height>1200</height>
                <rate>59.950</rate>
              </mode>
            </monitor>
          </logicalmonitor>
          <logicalmonitor>
            <x>0</x>
            <y>0</y>
            <scale>1</scale>
            <primary>yes</primary>
            <monitor>
              <monitorspec>
                <connector>DP-2</connector>
                <vendor>ACR</vendor>
                <product>Acer KG271 C</product>
                <serial>0x9231f806</serial>
              </monitorspec>
              <mode>
                <width>1920</width>
                <height>1080</height>
                <rate>60.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
        </configuration>
        <configuration>
          <layoutmode>physical</layoutmode>
          <logicalmonitor>
            <x>1920</x>
            <y>0</y>
            <scale>1</scale>
            <monitor>
              <monitorspec>
                <connector>HDMI-1</connector>
                <vendor>SAM</vendor>
                <product>SAMSUNG</product>
                <serial>0x00000800</serial>
              </monitorspec>
              <mode>
                <width>1920</width>
                <height>1080</height>
                <rate>60.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
          <logicalmonitor>
            <x>0</x>
            <y>0</y>
            <scale>1</scale>
            <primary>yes</primary>
            <monitor>
              <monitorspec>
                <connector>DP-2</connector>
                <vendor>DEL</vendor>
                <product>DELL U2415</product>
                <serial>7MT0177A2T2S</serial>
              </monitorspec>
              <mode>
                <width>1920</width>
                <height>1200</height>
                <rate>59.950</rate>
              </mode>
            </monitor>
          </logicalmonitor>
        </configuration>
        <configuration>
          <layoutmode>physical</layoutmode>
          <logicalmonitor>
            <x>0</x>
            <y>0</y>
            <scale>2</scale>
            <primary>yes</primary>
            <monitor>
              <monitorspec>
                <connector>HDMI-1</connector>
                <vendor>XXX</vendor>
                <product>Beyond TV</product>
                <serial>0x00010000</serial>
              </monitorspec>
              <mode>
                <width>3840</width>
                <height>2160</height>
                <rate>60.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
          <disabled>
            <monitorspec>
              <connector>DP-2</connector>
              <vendor>DEL</vendor>
              <product>DELL U2415</product>
              <serial>7MT0177A2T2S</serial>
            </monitorspec>
            <monitorspec>
              <connector>DP-3</connector>
              <vendor>ACR</vendor>
              <product>Acer KG271 C</product>
              <serial>0x9231f806</serial>
            </monitorspec>
          </disabled>
        </configuration>
        <configuration>
          <layoutmode>physical</layoutmode>
          <logicalmonitor>
            <x>0</x>
            <y>0</y>
            <scale>1</scale>
            <monitor>
              <monitorspec>
                <connector>DP-2</connector>
                <vendor>DEL</vendor>
                <product>DELL U2415</product>
                <serial>7MT0177A2T2S</serial>
              </monitorspec>
              <mode>
                <width>1920</width>
                <height>1200</height>
                <rate>59.950</rate>
              </mode>
            </monitor>
          </logicalmonitor>
          <logicalmonitor>
            <x>3840</x>
            <y>0</y>
            <scale>1</scale>
            <primary>yes</primary>
            <monitor>
              <monitorspec>
                <connector>HDMI-1</connector>
                <vendor>SAM</vendor>
                <product>SAMSUNG</product>
                <serial>0x00000800</serial>
              </monitorspec>
              <mode>
                <width>1920</width>
                <height>1080</height>
                <rate>60.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
          <logicalmonitor>
            <x>1920</x>
            <y>0</y>
            <scale>1</scale>
            <monitor>
              <monitorspec>
                <connector>DP-3</connector>
                <vendor>ACR</vendor>
                <product>Acer KG271 C</product>
                <serial>0x9231f806</serial>
              </monitorspec>
              <mode>
                <width>1920</width>
                <height>1080</height>
                <rate>60.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
        </configuration>
        <configuration>
          <layoutmode>physical</layoutmode>
          <logicalmonitor>
            <x>3840</x>
            <y>0</y>
            <scale>1</scale>
            <monitor>
              <monitorspec>
                <connector>DP-1</connector>
                <vendor>ACR</vendor>
                <product>G246HL</product>
                <serial>LWAEE0188563</serial>
              </monitorspec>
              <mode>
                <width>1920</width>
                <height>1080</height>
                <rate>60.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
          <logicalmonitor>
            <x>1920</x>
            <y>0</y>
            <scale>1</scale>
            <primary>yes</primary>
            <monitor>
              <monitorspec>
                <connector>DP-2</connector>
                <vendor>ACR</vendor>
                <product>Acer KG271 C</product>
                <serial>0x9231f806</serial>
              </monitorspec>
              <mode>
                <width>1920</width>
                <height>1080</height>
                <rate>144.001</rate>
              </mode>
            </monitor>
          </logicalmonitor>
          <logicalmonitor>
            <x>0</x>
            <y>0</y>
            <scale>1</scale>
            <monitor>
              <monitorspec>
                <connector>DP-3</connector>
                <vendor>DEL</vendor>
                <product>DELL U2415</product>
                <serial>7MT0177A2T2S</serial>
              </monitorspec>
              <mode>
                <width>1920</width>
                <height>1200</height>
                <rate>59.950</rate>
              </mode>
            </monitor>
          </logicalmonitor>
          <logicalmonitor>
            <x>5760</x>
            <y>0</y>
            <scale>2</scale>
            <monitor>
              <monitorspec>
                <connector>HDMI-1</connector>
                <vendor>XXX</vendor>
                <product>Beyond TV</product>
                <serial>0x00010000</serial>
              </monitorspec>
              <mode>
                <width>3840</width>
                <height>2160</height>
                <rate>60.000</rate>
              </mode>
              <colormode>bt2100</colormode>
            </monitor>
          </logicalmonitor>
        </configuration>
        <configuration>
          <layoutmode>physical</layoutmode>
          <logicalmonitor>
            <x>0</x>
            <y>0</y>
            <scale>2</scale>
            <primary>yes</primary>
            <monitor>
              <monitorspec>
                <connector>HDMI-1</connector>
                <vendor>XXX</vendor>
                <product>Beyond TV</product>
                <serial>0x00010000</serial>
              </monitorspec>
              <mode>
                <width>3840</width>
                <height>2160</height>
                <rate>60.000</rate>
              </mode>
              <colormode>bt2100</colormode>
            </monitor>
          </logicalmonitor>
        </configuration>
        <configuration>
          <layoutmode>physical</layoutmode>
          <logicalmonitor>
            <x>1920</x>
            <y>0</y>
            <scale>1</scale>
            <transform>
              <rotation>left</rotation>
              <flipped>no</flipped>
            </transform>
            <monitor>
              <monitorspec>
                <connector>DP-3</connector>
                <vendor>DEL</vendor>
                <product>DELL U2415</product>
                <serial>7MT0177A2T2S</serial>
              </monitorspec>
              <mode>
                <width>1920</width>
                <height>1200</height>
                <rate>59.950</rate>
              </mode>
            </monitor>
          </logicalmonitor>
          <logicalmonitor>
            <x>0</x>
            <y>0</y>
            <scale>1</scale>
            <primary>yes</primary>
            <monitor>
              <monitorspec>
                <connector>DP-2</connector>
                <vendor>ACR</vendor>
                <product>Acer KG271 C</product>
                <serial>0x9231f806</serial>
              </monitorspec>
              <mode>
                <width>1920</width>
                <height>1080</height>
                <rate>60.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
        </configuration>
      </monitors>
    ''}"
  ];

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
        gfxmodeEfi = "1280x1024";
        extraEntries = ''
          menuentry "Windows 11" {
              insmod part_gpt
              insmod fat
              set root=(hd0,gpt2)
              chainloader /EFI/Microsoft/Boot/bootmgfw.efi
          }
        '';
      };
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };
    "/mnt/500GB_SATA" = {
      device = "/dev/disk/by-label/500GB_SATA";
      fsType = "ntfs";
      options = [
        "nofail"
      ];
    };
    "/mnt/500GB_NVME" = {
      device = "/dev/disk/by-label/500GB_NVME";
      fsType = "ntfs";
      options = [
        "nofail"
      ];
    };
  };

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  networking.firewall.enable = false;

  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    i2c.enable = true;
  };
  system.stateVersion = "23.11";
}
