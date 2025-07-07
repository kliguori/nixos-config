{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      # Tools needed by Neovim plugins or LSPs
      ripgrep
      fd
      tree-sitter
      nodejs
      python3
      gcc
      gnumake

      # LSP servers
      ocamlPackages.ocamllsp
      nil
      clang-tools    # provides clangd
      python3Packages.python-lsp-server
      texlab         # for LaTeX
    ];

    plugins = with pkgs.vimPlugins; [
      gruvbox
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      telescope-nvim
      lualine-nvim

      nvim-cmp
      cmp-nvim-lsp
      luasnip
      cmp_luasnip
    ];

    extraLuaConfig = ''
      -- UI
      vim.o.number = true
      vim.o.relativenumber = true
      vim.o.termguicolors = true
      vim.cmd("colorscheme gruvbox")
      require("lualine").setup()

      -- Treesitter
      require("nvim-treesitter.configs").setup {
        highlight = { enable = true },
      }

      -- Completion
      local cmp = require("cmp")
      cmp.setup {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        })
      }

      -- LSP servers
      local lspconfig = require("lspconfig")

      -- OCaml
      lspconfig.ocamllsp.setup {}

      -- Nix
      lspconfig.nil_ls.setup {}

      -- C/C++
      lspconfig.clangd.setup {}

      -- Python
      lspconfig.pylsp.setup {}

      -- LaTeX
      lspconfig.texlab.setup {}
    '';
  };
}
