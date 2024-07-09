{ config, ... }:

{
  hardware = {
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

    nvidia = {
      modesetting.enable = true;
      open = false;
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
