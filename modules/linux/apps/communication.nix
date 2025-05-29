{pkgs, ...}: {
  environment.defaultPackages = with pkgs; [
    discord
  ];
}
