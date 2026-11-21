{
  proton-pass,
  pkgs,
}:
proton-pass.overrideAttrs (old: rec {
  version = "1.43.1";

  src = pkgs.fetchurl {
    url = "https://proton.me/download/pass/linux/x64/proton-pass_${version}_amd64.deb";
    hash = "sha256-8iOJiqZdTa3vjbIJ/o2+AxIJYO3RQCYgrrMqo1kdcGI=";
  };
})
