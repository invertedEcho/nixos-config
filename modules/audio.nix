{pkgs, ...}: {
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
  environment.systemPackages = with pkgs; [
    # for safety hearing notify script
    # need for pactl
    pulseaudio
    bc
  ];
}
