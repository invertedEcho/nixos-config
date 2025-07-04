{
  programs.hyprlock = {
    enable = true;
    settings = {
      background = {
        color = "rgb(282828)";
      };
      input-field = {
        size = "200, 30";
        outline_thickness = "1";
        rounding = 10;
        outer_color = "rgb(665c54)";
        inner_color = "rgb(3c3836)";
        font_color = "rgb(ebdbb2)";
        check_color = "rgb(d79921)";
        fail_color = "rgb(cc241d)";
        fade_on_empty = false;
        placeholder_text = "";
        fail_text = "Failed to unlock";
      };

      label = {
        text = "$TIME";
        color = "rgb(ebdbb2)";
        font_size = 45;
        font_family = "JetBrains Mono Nerd Font Mono Semibold";
        position = "0, 60";
        halign = "center";
        valign = "center";
      };
      auth = {
        fingerprint = {
          enabled = true;
          # TODO: I dont see any text ):
          ready_message = "Scan fingerprint to unlock";
          present_message = "Scanning fingerprint";
        };
      };
    };
  };
}
