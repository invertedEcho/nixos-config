{pkgs, ...}: let
  inherit (pkgs.unstable);
in {
  environment.systemPackages = with pkgs; [
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
    go
  ];
}
