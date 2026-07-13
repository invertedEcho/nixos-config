{pkgs, ...}: {
  imports = [
    ./base.nix
  ];
  environment.systemPackages = with pkgs; [
    chromium
    onlyoffice-desktopeditors
    spek
    feishin
    vscode
    jellyfin-media-player
    localsend
    unstable.godot-mono
    dotnet-sdk
    obsidian
    eclipses.eclipse-java
    proton-vpn
    unstable.proton-pass
    songrec
  ];
}
