# secrets.nix
let
  myUser = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICLD5PZ6t/dA+pUXHdnkJJy4hbyCngMhQmCKaG4oLdT7";
in {
  "eduroam.age".publicKeys = [myUser];
}
