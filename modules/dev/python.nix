{pkgs}: {
  environment.defaultPackages = with pkgs; [
    jetbrains.pycharm-community-bin
  ];
}
