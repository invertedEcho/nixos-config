{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    neovim
    aerospace
    nixd
    alejandra
    kitty
    raycast
    zoxide
    fzf
    ripgrep
    pure-prompt
    lazygit
    trash-cli
    gnupg1
    kitty
    cloudflared
    zsh-autosuggestions
    pdftk
    mariadb
  ];

  homebrew = {
    enable = true;
    casks = [
      "notion"
      "1password"
      "android-studio"
      "whatsapp"
      "vmware-fusion"
      "flutter"
      "steam"
    ];
  };
}
