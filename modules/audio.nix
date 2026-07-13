{...}: {
  # pulseaudio and pipewire use this to acquirie realtime priority
  security.rtkit.enable = true;

  services = {
    # airplay
    avahi.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      raopOpenFirewall = true;

      # airplay
      extraConfig.pipewire = {
        "10-airplay" = {
          "context.modules" = [
            {
              name = "libpipewire-module-raop-discover";

              # increase the buffer size if you get dropouts/glitches
              # args = {
              #   "raop.latency.ms" = 500;
              # };
            }
          ];
        };
        "10-low-latency" = {
          context.properties = {
            # Set default quantum (buffer size)
            # Lower values = lower latency but higher CPU load
            default.clock.quantum = 256;

            # Minimum and maximum allowed quantum
            default.clock.min-quantum = 32;
            default.clock.max-quantum = 8192;

            # Sample rate
            default.clock.rate = 48000;

            # Allowed rates (PipeWire will auto-select based on content)
            default.clock.allowed-rates = [44100 48000 88200 96000];
          };
          # "context.properties" = {
          #   "default.clock.rate" = 48000;
          #   "default.clock.quantum" = 1024;
          #   "default.clock.min-quantum" = 512;
          #   "default.clock.max-quantum" = 2048;
          # };
        };
      };
    };
  };
  programs.noisetorch.enable = true;
}
