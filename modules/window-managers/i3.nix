{pkgs, ...}: {
  services.xserver = {
    enable = true;
    dpi =
      if pkgs.system == "aarch64-linux"
      # Macbook vm
      then 220
      else null;
    windowManager.i3 = {
      enable = true;
    };
  };

  environment.defaultPackages = with pkgs; [
    xclip
    # TODO: Fix wezterm in i3
    kitty
  ];
}
