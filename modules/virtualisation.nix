{pkgs, ...}: {
  programs.virt-manager.enable = true;
  # TODO: Username should come from input arg
  users.groups.libvirt.members = ["echo"];
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.vhostUserPackages = [pkgs.virtiofsd];
    };
    spiceUSBRedirection.enable = true;
  };
}
