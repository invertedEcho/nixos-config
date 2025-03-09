{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    aerospace
    alejandra
    raycast
    zoxide
    pure-prompt
    trash-cli
    gnupg1
    zsh-autosuggestions
    pdftk
    mariadb
    flutter
    pnpm
  ];

  homebrew = {
    enable = true;
    brews = [
      "docker"
      "colima"
      "docker-compose"
      "ruby"
    ];
    casks = [
      "1password"
      "android-studio"
      "vmware-fusion"
      "firefox"
      "font-jetbrains-mono-nerd-font"
      "microsoft-excel"
    ];
  };
}
