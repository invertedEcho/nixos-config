{pkgs, ...}: let
  inherit (pkgs.unstable);
in {
  environment.systemPackages = with pkgs; [
    # Big desktop apps
    # jellyfin-media-player
    # jetbrains.pycharm-community-bin
    # onlyoffice-bin
    # vscode-fhs
    unstable.proton-pass
    pyright
    neovim
    wineWowPackages.stable
    wineWowPackages.waylandFull
    pinta
    geteduroam-cli
    black
    obsidian
    vlc
    discord
    # ldtk
    gnumake
    python3
    pkg-config
    openjdk17-bootstrap
    shellcheck
    glib
    alejandra
    openssl
    ngrok
    gcc13
    nixd
    lazygit
    kitty
    lua-language-server
    stylua
    fzf
    ripgrep
    rustup
    nodejs
    go
    nodePackages_latest.typescript-language-server
    nodePackages.bash-language-server
    nodePackages.eslint
    tailwindcss-language-server
    prettierd
    lua-language-server
    stylua
    corepack_22
    android-tools
    gimp3
    poppler-utils
    cloudflared
    vim
    htop
    wget
    loupe
    pavucontrol
    nautilus
    gnome-disk-utility
    lazygit
    ripgrep
    file
    playerctl
    libimobiledevice
    ifuse
    util-linux
    jq
    kooha
    rclone
    act
    solaar
    polkit
    polkit_gnome
    nixfmt-classic
    inetutils
    unrar
    unzip
    squashfsTools
    fzf
    pamixer
    dmg2img
    usbutils
    pciutils
    rpi-imager
    wev
    dnsutils
    gnome-characters
    lsof
    trash-cli
    gnome-calculator
    bat
    ntfs3g
    baobab
    cpufrequtils
    ddcutil
    ddcui
  ];
}
