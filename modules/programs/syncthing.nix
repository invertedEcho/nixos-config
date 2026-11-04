{
  services.syncthing = {
    enable = true;
    user = "echo";
    configDir = "/home/echo/.config/syncthing";
    dataDir = "/home/echo/Syncthing";
  };
}
