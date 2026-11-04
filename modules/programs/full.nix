{pkgs, ...}: {
  imports = [
    ./base.nix
  ];
  environment.systemPackages = with pkgs; [
    feishin
    vscodium-fhs
    vesktop # works better than vanilla discord
    # unstable.rstudio
    libreoffice-qt
    chromium
    protonmail-bridge-gui
    filezilla
    thunderbird
    libresprite
    signal-desktop
    easyeffects
    plezy
    audacity
    onlyoffice-desktopeditors
    spek
    localsend
    # fixes obsidian icon missing
    (pkgs.obsidian.overrideAttrs (old: {
      postFixup =
        (old.postFixup or "")
        + ''
          f=$out/share/applications/obsidian.desktop
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
