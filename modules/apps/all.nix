{pkgs, ...}: let
  inherit (pkgs.unstable);
in {
  # TODO: split this list into multiple modules and categorize
  environment.systemPackages = with pkgs; [
    gimp3
    poppler_utils
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
    pinentry
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
    _1password-gui
    wev
    dnsutils
    gnome-characters
    lsof
    trash-cli
    gnome-calculator
    bat
    ntfs3g
    notesnook
    baobab
    cpufrequtils
    onlyoffice-bin
    ddcutil
    ddcui
  ];
}
