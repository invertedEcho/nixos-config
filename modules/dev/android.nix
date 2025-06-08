{pkgs}: {
  environment.defaultPackages = with pkgs; [
    android-studio
    android-tools
  ];
}
