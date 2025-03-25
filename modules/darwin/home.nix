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
          rev = "515835a4e93734d77173bd4fcb631c28cddd79f2";
          hash = "sha256-fV6H6pr2UKW+JybVP+qUi/rtS8G1X1TBvFNc2BvdmrM=";
        };
        recursive = true;
      };
    };
  };

  programs.home-manager.enable = true;
}
