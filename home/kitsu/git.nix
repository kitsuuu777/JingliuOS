{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Kitsu";
        email = "323778819+kitsuuu777@users.noreply.github.com";
      };

      init.defaultBranch = "main";
      pull.rebase = false;
      push.autoSetupRemote = true;
      rerere.enabled = true;
    };
  };
}
