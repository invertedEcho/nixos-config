{
  programs.firefox = {
    enable = true;
    policies = {
      SearchEngines = {
        Default = "DuckDuckGo";
      };
      DisablePocket = true;
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisplayBookmarksToolbar = "never";
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisableFirefoxScreenshots = true;
      ExtensionSettings = {
        "langpack-de@firefox.mozilla.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4510149/deutsch_de_language_pack-139.0.20250609.112858.xpi";
          installation_mode = "force_installed";
        };
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "{995463c6-18a1-4cf7-b0f1-564e050d778b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/3785565/tokyonight_vim-1.4.xpi";
          installation_mode = "force_installed";
        };
        "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4458679/vimium_ff-2.2.1.xpi";
          installation_mode = "force_installed";
        };
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4488139/darkreader-4.9.106.xpi";
          installation_mode = "force_installed";
        };
        "78272b6fa58f4a1abaac99321d503a20@proton.me" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4686427/proton_pass-1.34.2.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };
}
