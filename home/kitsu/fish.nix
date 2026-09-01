{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set -g fish_greeting
    '';

    shellAliases = {
      ll = "ls -lah";
      la = "ls -A";
      ".." = "cd ..";
      "..." = "cd ../..";
      rebuild = "sudo nixos-rebuild switch --flake ~/jingliuOS#jingliuOS";
      ntest = "sudo nixos-rebuild test --flake ~/jingliuOS#jingliuOS";
    };

    functions = {
      fish_prompt = {
        body = ''
          set -l last_status $status

          set_color 8EAEDB
          printf "╭─ "

          set_color AAB7CA
          printf "%s" (prompt_pwd)

          if test $last_status -ne 0
            set_color 6F2336
            printf " ✗%s" $last_status
          end

          printf "\n"

          set_color 9CB9EA
          printf "╰─❯ "

          set_color normal
        '';
      };
    };
  };
}
