{pkgs, ...}: {
  imports = [
    ./base.nix
  ];
  environment.systemPackages = with pkgs; [
    audacity
    chromium
    onlyoffice-desktopeditors
    spek
    feishin
    vscode
    jellyfin-media-player
    localsend
    unstable.godot-mono
    dotnet-sdk_10
    dotnet-runtime_10
    obsidian
    eclipses.eclipse-java
    proton-vpn
    unstable.proton-pass
    songrec
  ];
}
