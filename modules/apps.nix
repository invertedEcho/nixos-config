{ pkgs, ... }:

let inherit (pkgs.unstable) ;
in {
  environment.systemPackages = with pkgs; [
    unstable.neovim
    # TODO: move to stable once ver 1.11.0 reaches stable
    unstable.rbw
    rustup
    gnumake
    vim
    htop
    killall
    wget
    firefox
    neovim
    kitty
    wl-clipboard
    loupe
    wofi
    pavucontrol
    python3
    wezterm
    gcc13
    mpv
    gnome.nautilus
    gnome.gnome-disk-utility
    waybar
    webcord
    xwayland
    lazygit
    nodePackages.typescript-language-server
    nodePackages.bash-language-server
    nodePackages.pyright
    nodePackages.eslint
    python311Packages.jedi-language-server
    tailwindcss-language-server
    prettierd
    ripgrep
    vscode-langservers-extracted
    iwgtk
    file
    grim
    slurp
    tokyo-night-gtk
    libnotify
    gammastep
    playerctl
    libimobiledevice
    ifuse
    chromium
    swaybg
    util-linux
    waypaper
    jq
    lua-language-server
    stylua
    nodejs_22
    corepack_22
    pkg-config
    openssl
    android-tools
    vulkan-tools
    rofi-rbw-wayland
    pinentry
    wtype
    php83Packages.composer
    nh
    hyprlock
    protonmail-bridge-gui
    thunderbird
    statix
    swaynotificationcenter
    kooha
    openjdk17-bootstrap
    rclone
    postgresql_16
    act
    solaar
    wlogout
    polkit
    polkit_gnome
    nixfmt-classic
    onlyoffice-bin
    inetutils
    parted
    appimage-run
    pass
    jetbrains.idea-community-bin
    android-studio
    shellcheck
    stripe-cli
    unrar
    tmux
    unzip
    sway
    brightnessctl
    squashfsTools
    wdisplays
    flutter
    glib
    fzf
  ];
}
