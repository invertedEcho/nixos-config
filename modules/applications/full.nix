{pkgs, ...}: {
  imports = [
    ./base.nix
  ];
  environment.systemPackages = with pkgs; [
    vesktop # works better than vanilla discord
    gelly
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
    obsidian
    proton-vpn
    proton-pass # comes from my overlay
    songrec
  ];
}
