{pkgs}: {
  environment.defaultPackages = with pkgs; [
    jetbrains.pycharm-community-bin
    # TODO: Decide on one python lsp server
    pyright
    python311Packages.jedi-language-server
    python312Packages.flake8
  ];
}
