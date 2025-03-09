{pkgs, ...}: {
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # virtualisation.libvirtd = {
  #   enable = true;
  #   qemu = {
  #     package = pkgs.qemu_kvm;
  #     runAsRoot = true;
  #     swtpm.enable = true;
  #     ovmf = {
  #       enable = true;
  #       packages = [
  #         (pkgs.OVMF.override {
  #           secureBoot = true;
  #           tpmSupport = true;
  #         }).fd
  #       ];
  #     };
  #   };
  # };

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };

    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    git = {
      enable = true;
      config = {push.autoSetupRemote = true;};
    };

    zsh.enable = true;

    adb.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    tmux.enable = true;
  };
}
