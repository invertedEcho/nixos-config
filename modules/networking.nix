{
  lib,
  pkgs,
  config,
  ...
}: {
  networking = {
    useDHCP = lib.mkDefault true;
    networkmanager = {
      enable = true;
      wifi.powersave = true;
      plugins = with pkgs; [
        networkmanager-openvpn
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    cacert
  ];

  security.pki.certificateFiles = [
    # This certificate is publicly available, so no issue adding it to VCS
    ../assets/ca-cert.pem
  ];

  # Caveats:
  # Declaratively define NetworkManager profiles. You can find information about the generated file format here and here. You current profiles which are most likely stored in /etc/NetworkManager/system-connections and there is a tool to convert them to the needed nix code. If you add a new ad-hoc connection via a GUI or nmtui or anything similar it should just work together with the declarative ones. And if you edit a declarative profile NetworkManager will move it to the persistent storage and treat it like a ad-hoc one, but there will be two profiles as soon as the systemd unit from this option runs again which can be confusing since NetworkManager tools will start displaying two profiles with the same name and probably a bit different settings depending on what you edited. A profile won’t be deleted even if it’s removed from the config until the system reboots because that’s when NetworkManager clears it’s temp directory. If networking.resolvconf.enable is true, attributes affecting the name resolution (such as ignore-auto-dns) may not end up changing /etc/resolv.conf as expected when other name services (for example networking.dhcpcd) are enabled. Run resolvconf -l in the terminal to see what each service produces.
  networking.networkmanager.ensureProfiles = {
    environmentFiles = [config.age.secrets.eduroam.path];
    profiles."eduroam" = {
      connection = {
        id = "eduroam";
        type = "wifi";
        autoconnect = true;
        interface = "wlp0s20f3";
      };
      wifi = {
        ssid = "eduroam";
        mode = "infrastructure";
        key-mgmt = "WPA-EAP";
      };
      wifi-security = {
        key-mgmt = "wpa-eap";
      };
      "802-1x" = {
        eap = "ttls";
        identity = "$IDENTITY";
        password = "$PASSWORD";
        anonymous-identity = "eduroam@tha.de";
        phase2-auth = "pap";
        ca-cert = "/etc/ssl/certs/ca-bundle.crt";
        domain-suffix-match = "hs-augsburg.de";
      };
      ipv4.method = "auto";
      ipv6.method = "auto";
    };
  };
}
