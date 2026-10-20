{
  gelly,
  fetchFromGitHub,
}:
gelly.overrideAttrs (old: rec {
  version = "1.16.3";

  src = fetchFromGitHub {
    owner = "Fingel";
    repo = "gelly";
    tag = "v${version}";
    hash = "sha256-YpSES6qf9W7oj2LIQcI48N2SxMbVRumQ2zxsnYgMdlg=";
  };
})
