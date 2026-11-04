{
  proton-pass,
  pkgs,
}:
proton-pass.overrideAttrs (old: rec {
  version = "1.43.0";

  src = pkgs.fetchurl {
    url = "https://proton.me/download/pass/linux/x64/proton-pass_${version}_amd64.deb";
    hash = "sha256-n7fBG3VkIcAkgwVqMzL5qRwbyyX6VH85sygYI3lUTY4=";
  };
})
