{
  pkgs,
  ...
}:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    # Tooling installed from Nix (no Mason)
    extraPackages = with pkgs; [
      # Nix support
      nixd
      nixfmt-rfc-style

      # Python support
      pyright
      black
      ruff

      # OCaml support
      ocamlPackages.ocaml-lsp
      ocamlPackages.ocamlformat

      # C support
      clang-tools

      # LaTeX support
      texlab

      # For telescope
      ripgrep
      fd

      # Clipboards
      wl-clipboard
      xclip
    ];

    plugins = with pkgs.vimPlugins; [
      # Core
      bufferline-nvim
      neo-tree-nvim
      nui-nvim
      plenary-nvim
      nvim-web-devicons
      telescope-nvim
      telescope-file-browser-nvim
      telescope-fzf-native-nvim
      lualine-nvim

      # Treesitter
      (nvim-treesitter.withPlugins (
        p: with p; [
          tree-sitter-nix
          tree-sitter-python
          tree-sitter-ocaml
          tree-sitter-ocaml-interface
          tree-sitter-c
          tree-sitter-lua
          tree-sitter-bash
          tree-sitter-json
          tree-sitter-yaml
          tree-sitter-markdown
          tree-sitter-markdown-inline
          tree-sitter-toml
        ]
      ))

      # Themes
      dracula-nvim

      # LSP + completion
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip
      friendly-snippets
    ];

    extraLuaConfig = ''
      -- Basics
      vim.g.mapleader = " "
      vim.o.number = true
      vim.o.relativenumber = true
      vim.o.expandtab = true
      vim.o.shiftwidth = 2
      vim.o.tabstop = 2
      vim.o.updatetime = 200
      vim.o.signcolumn = "yes"
      vim.o.completeopt = "menuone,noselect"
      vim.o.termguicolors = true
      vim.o.clipboard = "unnamedplus"
      vim.cmd("colorscheme dracula")

      require("lualine").setup {}

      -- Buffer tabs (bufferline)
      require("bufferline").setup({
        options = {
          diagnostics = "nvim_lsp",      -- show LSP error/warn counts per tab
          show_buffer_close_icons = false,
          always_show_bufferline = true,
          -- If you later add nvim-tree/neo-tree, you can add an offset like:
          -- offsets = { { filetype = "neo-tree", text = "Explorer", separator = true } },
        },
      })

      -- Navigate buffers like tabs
      vim.keymap.set("n", "<Tab>",   "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
      vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })

      -- Pick / close / move
      vim.keymap.set("n", "<leader>bp", "<cmd>BufferLinePick<CR>",         { desc = "Pick buffer" })
      vim.keymap.set("n", "<leader>bc", "<cmd>bdelete<CR>",                { desc = "Close buffer" })
      vim.keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>",  { desc = "Close others" })
      vim.keymap.set("n", "<leader>b>", "<cmd>BufferLineMoveNext<CR>",     { desc = "Move buffer right" })
      vim.keymap.set("n", "<leader>b<", "<cmd>BufferLineMovePrev<CR>",     { desc = "Move buffer left" })

      -- Telescope (core + fzf + file-browser)
      local ok_t, telescope = pcall(require, "telescope")
      if ok_t then
        telescope.setup({
          extensions = {
            file_browser = {
              -- feel free to tweak these:
              grouped = true,              -- folders first
              hijack_netrw = true,         -- use this instead of netrw
              hidden = { file_browser = true, folder_browser = true },  -- show dotfiles
              respect_gitignore = false,   -- still show ignored files (toggle inside)
            },
          },
        })
        pcall(telescope.load_extension, "fzf")
        pcall(telescope.load_extension, "file_browser")

        local builtin = require("telescope.builtin")
        local fb = telescope.extensions.file_browser.file_browser

        -- Regular pickers
        vim.keymap.set("n", "<leader>ff", builtin.find_files,   { desc = "Telescope: Find files" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep,    { desc = "Telescope: Live grep" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers,      { desc = "Telescope: Buffers" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags,    { desc = "Telescope: Help tags" })
        vim.keymap.set("n", "<leader>fo", builtin.oldfiles,     { desc = "Telescope: Recent files" })
        vim.keymap.set("n", "<leader>fr", builtin.resume,       { desc = "Telescope: Resume last picker" })
        vim.keymap.set("n", "<leader>gc", builtin.git_commits,  { desc = "Telescope: Git commits" })
        vim.keymap.set("n", "<leader>gs", builtin.git_status,   { desc = "Telescope: Git status" })
        vim.keymap.set("n", "<leader>fd", builtin.diagnostics,  { desc = "Telescope: Diagnostics" })

        -- Explorer-style file browser
        -- Open at current file's directory (normal-mode by default, no preview)
        vim.keymap.set("n", "<leader>e", function()
          fb({
            cwd = vim.fn.expand("%:p:h"),
            previewer = false,
            initial_mode = "normal",
          })
        end, { desc = "Explorer: file dir" })

        -- Open at project root (git) or cwd fallback
        vim.keymap.set("n", "<leader>E", function()
          local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
          local cwd = (git_root ~= nil and git_root ~= "") and git_root or vim.loop.cwd()
          fb({
            cwd = cwd,
            previewer = false,
            initial_mode = "normal",
          })
        end, { desc = "Explorer: project root" })

        -- Handy: "go up a directory" feel with "-" (open at cwd)
        vim.keymap.set("n", "-", function()
          fb({
            cwd = vim.loop.cwd(),
            previewer = false,
            initial_mode = "normal",
          })
        end, { desc = "Explorer: cwd" })
      else
        vim.notify("telescope not found", vim.log.levels.WARN)
      end

      -- Treesitter
      require("nvim-treesitter.configs").setup {
        highlight = { enable = true },
        indent = { enable = true },
      }

      -- Completion
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup {
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"]   = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<CR>"]    = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "path" },
          { name = "buffer" },
        }),
      }

      -- LSP with cmp capabilities
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      -- Nix 
      lspconfig.nixd.setup {
        capabilities = capabilities,
        settings = { nixd = { formatting = { command = { "nixfmt" } } } },
      }

      -- Python 
      lspconfig.pyright.setup { capabilities = capabilities }

      -- OCaml
      lspconfig.ocamllsp.setup { capabilities = capabilities }

      -- C/C++
      lspconfig.clangd.setup { capabilities = capabilities }

      -- LaTeX
      lspconfig.texlab.setup { capabilities = capabilities }

      -- Simple LSP keymaps when a server attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n","K",  vim.lsp.buf.hover, opts)
          vim.keymap.set("n","<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n","<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n","<leader>f", function() vim.lsp.buf.format({ async = false }) end, opts)
        end
      })
    '';
  };
}
