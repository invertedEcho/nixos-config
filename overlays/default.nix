# https://nixos-and-flakes.thiscute.world/nixpkgs/overlays
{inputs, ...}: {
  nixpkgs.overlays = [
    # Overlay 2: Use `final` and `prev` to express
    # the relationship between the new and the old
    (final: prev: {
      mousefollowsfocus = final.callPackage ../packages/mousefollowsfocus {};
      ddcutil = prev.ddcutil.overrideAttrs (old: {
        version = "2.2.5";

        src = prev.fetchurl {
          url = "https://www.ddcutil.com/tarballs/ddcutil-2.2.5.tar.gz";
          hash = "sha256-eV6uVI1JYR6YnNSQRq/1jZLheSwNq7Zz7Su9Ab1PH48=";
        };
      });
      unstable = import inputs.nixpkgs-unstable {
        system = "x86_64-linux";
        config = {allowUnfree = true;};
      };
    })
  ];
}
