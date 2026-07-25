{
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation {
  pname = "mousefollowsfocus";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "invertedEcho";
    repo = "mousefollowsfocus";
    rev = "f56c9a0c2f322ff4f82e3b53ef756fb84c3a0d85";
    hash = "sha256-esk3bE32upFp3DfugIphcCjT3KOsLHK6Lmhm0AINClQ=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/gnome-shell/extensions/
    cp -r -T . $out/share/gnome-shell/extensions/mousefollowsfocus@invertedecho

    runHook postInstall
  '';
}
