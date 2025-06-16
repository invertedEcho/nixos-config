{
  programs.git = {
    enable = true;
    userName = "Jakob Stechow";
    userEmail = "jakob.stechow@pm.me";
    signing = {
      format = "ssh";
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICLD5PZ6t/dA+pUXHdnkJJy4hbyCngMhQmCKaG4oLdT7";
      signByDefault = true;
    };
    extraConfig = {
      gpg."ssh".program = "/run/current-system/sw/bin/op-ssh-sign";
    };
  };
}
