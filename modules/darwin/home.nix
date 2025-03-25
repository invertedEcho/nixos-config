# home.nix
{
  config,
  pkgs,
  ...
}: {
  home = {
    username = "invertedecho";
    stateVersion = "23.11";
    file = {
      "${config.xdg.configHome}" = {
        source = pkgs.fetchFromGitHub {
          owner = "invertedEcho";
          repo = "dotfiles";
          rev = "c1ab8f86bef41d995acda3311a5519a99698d603";
          hash = "sha256-wxYc5LyLu+d4H4mdBG/zxv9GBd6uLG2inUvpvrjUwyw";
        };
        recursive = true;
      };
      "${config.xdg.configHome}/nvim" = {
        source = pkgs.runCommand "nvim-config" {} ''
          src=${pkgs.fetchFromGitHub {
            owner = "invertedEcho";
            repo = "nvim-config";
            rev = "88f622e70bd0d3cb110cac5996db893bb7214061";
            hash = "sha256-hpJ+BuWUzxcjyRAHJA8vIDEbeSQKHY+lwWa+qckztf0=";
          }}

          mkdir -p $out
          cp -r $src/nvim/* $out/
        '';
        recursive = true;
      };
    };
  };

  programs.home-manager.enable = true;
}
