{
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        # Shows battery charge of connected devices on supported bluetooth adapters.
        Experimental = true;
        # When enabled other devices can connect faster to us, however
        # the tradeoff is increased power consumption. Defaults to
        # 'false'.
        FastConnectable = true;
      };
    };
  };
}
