{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    neovim
    aerospace
    nixd
    alejandra
    raycast
    zoxide
    fzf
    ripgrep
    pure-prompt
    lazygit
    trash-cli
    gnupg1
    kitty
    zsh-autosuggestions
    pdftk
    mariadb
    rustup
    nodejs
    lua-language-server
    flutter
    pnpm
    stylua
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
      # "flutter"
      "firefox"
      "font-jetbrains-mono-nerd-font"
      "microsoft-excel"
    ];
  };
}
