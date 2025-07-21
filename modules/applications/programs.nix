{
  programs = {
    ssh = {
      extraConfig = "
Host *
  IdentityAgent ~/.1password/agent.sock
Host homeserver
  HostName ssh.invertedecho.com
  ProxyCommand /run/current-system/sw/bin/cloudflared access ssh --hostname %h
	";
    };

    git = {
      enable = true;
      config = {push.autoSetupRemote = true;};
    };

    zsh.enable = true;

    adb.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    tmux.enable = true;
  };
}
