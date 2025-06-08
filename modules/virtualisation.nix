{
  programs.virt-manager.enable = true;
  # TODO: Username should come from variable set somewhere
  users.groups.libvirt.members = ["echo"];
  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
}
