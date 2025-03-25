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
