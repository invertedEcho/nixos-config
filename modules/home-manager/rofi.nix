{
  config,
  pkgs,
  ...
}: {
  home.file = {
    "${config.xdg.configHome}/rofi" = {
      source = pkgs.runCommand "rofi-config" {} ''
        src=${pkgs.fetchFromGitHub {
          owner = "adi1090x";
          repo = "rofi";
          rev = "fb7011e";
          hash = "sha256-wwLcb7z5jCKgKPY5mNhYIoPvKbVO3PwULrJ+Lm3Ra7g=";
        }}

        # Workaround to be able to modify launcher.sh using $src/ is immutable by nix store
        cp -r $src/files rofi-files
        chmod -R u+w rofi-files

        sed -i -e "s/theme='style-1'/theme='style-4'/" rofi-files/launchers/type-6/launcher.sh

        mkdir -p $out
        cp -r rofi-files/* $out/
      '';
    };
  };
}
