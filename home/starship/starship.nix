{
  osConfig,
  ...
}:

let
  c = osConfig.theme.colors;
in
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = "$nix_shell$directory$git_branch$git_status$character";
      nix_shell = {
        format = "[($name)]($style) ";
        style = "bold yellow";
        heuristic = true;
      };
      character = {
        success_symbol = "[❯](bold ${c.green})";
        error_symbol = "[❯](bold ${c.red})";
      };
      directory.style = "bold ${c.cyan}";
      git_branch.style = "bold ${c.purple}";
      git_status.style = "bold ${c.orange}";
    };
  };
}
