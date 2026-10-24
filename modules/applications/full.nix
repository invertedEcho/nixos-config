{pkgs, ...}: {
  imports = [
    ./base.nix
  ];
  environment.systemPackages = with pkgs; [
    vesktop # works better than vanilla discord
    unstable.nocturne
    chromium
    protonmail-bridge-gui
    libresprite
    filezilla
    thunderbird
    libresprite
    karere
    signal-desktop
    easyeffects
    plezy
    audacity
    onlyoffice-desktopeditors
    spek
    localsend
    (pkgs.obsidian.overrideAttrs (old: {
      postFixup =
        (old.postFixup or "")
        + ''
          f=$out/share/applications/obsidian.desktop
          # make sure it's a writable regular file, not a symlink into another store path
          # cp --remove-destination "$(readlink -f "$f")" "$f"
          chmod u+w "$f"
          sed -i '/^StartupWMClass=/d' "$f"
          sed -i '/^\[Desktop Entry\]/a StartupWMClass=md.obsidian.Obsidian' "$f"
        '';
    }))
    proton-vpn
    proton-pass # comes from my overlay
    songrec
  ];
}
