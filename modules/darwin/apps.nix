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
    oh-my-zsh
    pure-prompt
    lazygit
    trash-cli
    gnupg1
    kitty
    cloudflared
  ];

  homebrew = {
    enable = true;
    casks = ["notion" "1password" "android-studio" "whatsapp" "vmware-fusion"];
  };
}
