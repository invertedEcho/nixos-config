{
  pkgs,
  config,
  ...
}: {
  boot.initrd.kernelModules = ["nvidia"];
  boot.blacklistedKernelModules = ["nouveau"];
  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      open = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
    };
  };

  services.xserver.videoDrivers = ["nvidia"];

  environment.systemPackages = with pkgs; [
    nvtopPackages.nvidia
  ];
}
