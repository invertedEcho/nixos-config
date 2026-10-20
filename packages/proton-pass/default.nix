{
  proton-pass,
  pkgs,
}:
proton-pass.overrideAttrs (old: rec {
  version = "1.42.0";

  src = pkgs.fetchurl {
    url = "https://proton.me/download/pass/linux/x64/proton-pass_${version}_amd64.deb";
    hash = "sha256-Z8BduD3UzlrHhNZzeXmpvpJUqK9PCfENVkyX9xuVVWQ=";
  };
})
