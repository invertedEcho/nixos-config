{
  programs.virt-manager.enable = true;
  # TODO: Username should come from variable set somewhere
  users.groups.libvirt.members = ["echo"];
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
}
