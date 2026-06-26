{inputs, ...}: {
  imports = [
    inputs.agenix.nixosModules.default
  ];
  age.identityPaths = ["/home/echo/.ssh/id_ed25519"];
  age.secrets.eduroam.file = ../secrets/eduroam.age;
}
