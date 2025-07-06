{ config, lib, pkgs, ... }:

let
  f = config.fonts;
  c = config.theme.colors;
in {
  programs.wofi.enable = true;

  xdg.configFile."wofi/style.css".text = ''
    /* ---------- Dracula + Font Shared Style ---------- */
    @define-color base        ${c.background};
    @define-color text        ${c.foreground};
    @define-color lavender    ${c.purple};
    @define-color mauve       ${c.pink};
    @define-color red         ${c.red};

    * {
      font-family: '${f.ui}', sans-serif;
      font-size: ${toString f.size}px;
    }

    window {
      margin: 0px;
      padding: 10px;
      border: 2px solid @lavender;
      border-radius: 8px;
      background-color: @base;
    }

    #inner-box, #outer-box, #scroll {
      margin: 5px;
      padding: 10px;
      border: none;
      background-color: @base;
    }

    #input {
      margin: 5px 20px;
      padding: 10px;
      border: none;
      border-radius: 0.1em;
      color: @text;
      background-color: @base;
    }

    #input image {
      border: none;
      color: @red;
    }

    #input * {
      outline: 4px solid @red !important;
    }

    #text {
      margin: 5px;
      border: none;
      color: @text;
    }

    #entry {
      background-color: @base;
    }

    #entry arrow {
      border: none;
      color: @lavender;
    }

    #entry:selected {
      border: 0.11em solid @lavender;
    }

    #entry:selected #text {
      color: @mauve;
    }

    #entry:drop(active) {
      background-color: @lavender !important;
    }
  '';
}
