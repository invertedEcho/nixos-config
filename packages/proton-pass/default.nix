{pkgs}:
pkgs.proton-pass.overrideAttrs (old: rec {
  version = "1.40.2";

  src = pkgs.fetchurl {
    url = "https://proton.me/download/pass/linux/x64/proton-pass_${version}_amd64.deb";
    hash = "sha256-NHpQ1eftyKrysqQ41XGfAbHEUZ7hjarTyOIBpsF2Vho=";
  };
})
