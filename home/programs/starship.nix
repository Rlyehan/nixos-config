{...}: {
  programs.starship = {
    enable = true;
    
    enableZshIntegration = true;
    settings = {
      format = "[░▒▓](#a3aed2)[   ](bg:#a3aed2 fg:#090c0c)[](bg:#769ff0 fg:#a3aed2)$directory[](fg:#769ff0 bg:#394260)$git_branch$git_status[](fg:#394260 bg:#212736)$nodejs$rust$golang$python[](fg:#212736 bg:#1d2230)$time[ ](fg:#1d2230)$character";
      add_line = true;
      directory = {
          style = "fg:#e3e5e5 bg:#769ff0";
	  format = "[$path]($style)";
	  home_symbol = "~";
	  truncate_to_repo = true;
          truncation_length = 3;
          truncation_symbol = "…/";
          use_logical_path = true;
          use_os_path_sep = true;
      };
        docker_context = {
          format = "[$symbol$context]($style) ";
          style = "blue bold bg:0x06969A";
          symbol = " ";
          only_with_files = true;
          disabled = false;
          detect_extensions = [];
          detect_files = [
            "docker-compose.yml"
            "docker-compose.yaml"
            "Dockerfile"
          ];
          detect_folders = [];
        };
	git_branch = {
	  only_attached = true;
	  symbol = "";
	  style = "bg:#394260";
	  format = "[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)";
	};
	git_status = {
	  style = "bg:#394260";
	  format = "[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)";
	  };
	nodejs = {
          format = "[$symbol($version )]($style)";
          not_capable_style = "bold red";
          style = "bg:#212736";
          symbol = " ";
          version_format = "v$raw";
          disabled = false;
          detect_extensions = [
            "js"
            "mjs"
            "cjs"
            "ts"
            "mts"
            "cts"
          ];
          detect_files = [
            "package.json"
            ".node-version"
            ".nvmrc"
          ];
          detect_folders = ["node_modules"];
        };
	rust = {
          format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
          version_format = "v$raw";
          symbol = " ";
          style = "bg:#212736";
          disabled = false;
          detect_extensions = ["rs"];
          detect_files = ["Cargo.toml"];
          detect_folders = [];
        };
	golang = {
          format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)'";
          symbol = " ";
          style = "bg:#212736";
          disabled = false;
          detect_extensions = ["go"];
          detect_files = [
            "go.mod"
            "go.sum"
            "glide.yaml"
            "Gopkg.yml"
            "Gopkg.lock"
            ".go-version"
          ];
          detect_folders = ["Godeps"];
        };
	time = {
	  disabled = false;
	  time_format = "%R";
	  style = "bg:#1d2230";
	  format = "[[  $time ](fg:#a0a9cb bg:#1d2230)]($style)";
	  };
    };
    };
}
