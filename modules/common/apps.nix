{pkgs, ...}: let
  inherit (pkgs.unstable);
in {
  environment.systemPackages = with pkgs; [
    unstable.neovim
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
