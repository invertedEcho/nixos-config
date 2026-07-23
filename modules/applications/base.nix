{pkgs, ...}: let
  inherit (pkgs.unstable);
in {
  environment.systemPackages = with pkgs; [
    neovide
    git-lfs
    roslyn-ls
    calibre
    discover-overlay
    lldb
    tmuxinator
    ffmpeg # convert audio/video to other formats
    multitail
    ffmpeg
    tree-sitter # required for nvim-treesitter to work
    google-java-format
    vivify
    java-language-server
    woeusb-ng
    cmake-language-server
    glsl_analyzer
    clang-tools
    cmake
    mpv
    gedit
    zoxide
    pure-prompt
    findutils.locate
    tela-icon-theme

    # required for nvidia nsight graphics
    libxcb-util

    vscode-json-languageserver
    tombi
    git
    waypaper
    unstable.proton-pass
    # Tools
    pyright
    unstable.neovim # for nvim 0.12
    black
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
    wezterm
    lua-language-server
    stylua
    fzf
    ripgrep
    nodejs
    go
    typescript-language-server
    bash-language-server
    eslint
    tailwindcss-language-server
    prettierd
    lua-language-server
    stylua
    corepack_22
    android-tools
    poppler-utils
    cloudflared
    vim
    htop
    wget
    loupe
    pavucontrol
    nautilus
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
    nixfmt
    inetutils
    unrar
    unzip
    squashfsTools
    fzf
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
