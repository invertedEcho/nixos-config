{
  services.hypridle = {
    enable = true;
    settings = {
      listener = [
        {
          # 10 min
          timeout = 600;
          on-timeout = "hyprlock";
        }
        {
          # 15 min
          timeout = 900;
          on-timeout = "systemctl suspend-then-hibernate";
        }
      ];
    };
  };
}
