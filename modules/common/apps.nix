{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    neovim
    nixd
    lazygit
    wezterm
    lua-language-server
    stylua
    android-tools
    fzf
    ripgrep
    rustup
    nodejs
  ];
}
