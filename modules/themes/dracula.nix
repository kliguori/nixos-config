{ pkgs, lib, config, ... }:{

  options.theme = lib.mkOption {
    type = lib.types.attrs;
    description = "Global theme object containing Dracula colors.";
    default = {};
  };

  config.theme = {
    name = "dracula";
    colors = {
      background = "#282a36";
      foreground = "#f8f8f2";
      selection  = "#44475a";
      comment    = "#6272a4";
      cyan       = "#8be9fd";
      green      = "#50fa7b";
      orange     = "#ffb86c";
      pink       = "#ff79c6";
      purple     = "#bd93f9";
      red        = "#ff5555";
      yellow     = "#f1fa8c";
    };
  };
}