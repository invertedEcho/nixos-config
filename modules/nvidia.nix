{
  pkgs,
  config,
  ...
}: {
  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      open = true;
    };
  };

  services.xserver.videoDrivers = ["nvidia"];

  environment.defaultPackages = with pkgs; [
    nvtopPackages.nvidia
  ];
}
