{config, ...}: {
  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      open = true;
    };
  };

  services.xserver.videoDrivers = ["nvidia"];
}
