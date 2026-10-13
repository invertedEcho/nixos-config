{pkgs, ...}: {
  imports = [
    ./base.nix
  ];
  environment.systemPackages = with pkgs; [
    chromium
    protonmail-bridge-gui
    libresprite
    filezilla
    thunderbird
    libresprite
    karere
    signal-desktop
    easyeffects
    discord
    plezy
    audacity
    onlyoffice-desktopeditors
    spek
    feishin
    localsend
    obsidian
    proton-vpn
    unstable.proton-pass
    songrec
  ];
}
