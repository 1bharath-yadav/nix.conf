{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      buf = {
          symbol = " ";
        };
        c = {
          symbol = " ";
        };
        cmake = {
          symbol = " ";
        };
        docker_context = {
          symbol = " ";
        };
#         fossil_branch = {
#           symbol = " ";
#         };
#         git_branch = {
#           symbol = " ";
#         };
        golang = {
          symbol = " ";
        };
        hg_branch = {
          symbol = " ";
        };
        hostname = {
          ssh_symbol = " ";
        };
        lua = {
          symbol = " ";
        };
        memory_usage = {
          symbol = "󰍛 ";
        };
        meson = {
          symbol = "󰔷 ";
        };
        nim = {
          symbol = "󰆥 ";
        };
        nix_shell = {
          symbol = " ";
        };
        nodejs = {
          symbol = " ";
        };
        ocaml = {
          symbol = " ";
        };
        package = {
          symbol = "󰏗 ";
        };
        python = {
          symbol = " ";
        };
        rust = {
          symbol = " ";
        };
        swift = {
          symbol = " ";
        };
        zig = {
          symbol = " ";
        };

      hostname = {
        ssh_only = false;
        format = "[$ssh_symbol$hostname]($style) ";
        style = "bold purple";
      };
      character = {
        success_symbol = "[ & ](bold green)";
        error_symbol = "[ & ](bold red)";
      };
      username = {
        show_always = true;
        format = "[$user]($style)@";
      };
      directory = {
        read_only = " 🔒";
        truncation_symbol = "…/";
      };
    };
  };
}
