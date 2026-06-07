{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # right now not needed bcs configuring through nix config
    # geteduroam-cli
  ];
}
