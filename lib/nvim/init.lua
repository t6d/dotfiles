-- Lightweight dev + ops focused Neovim configuration.
-- Single-file entry, kickstart.nvim style. Plugins managed by lazy.nvim.

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================================
-- Options
-- ============================================================================

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.termguicolors = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.splitright = true
opt.splitbelow = true
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true
opt.updatetime = 250
opt.timeoutlen = 400
opt.completeopt = { "menu", "menuone", "noselect" }
opt.inccommand = "split"
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- ============================================================================
-- Keymaps
-- ============================================================================

local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>")

map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Show diagnostic" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic list" })

-- ============================================================================
-- Autocmds
-- ============================================================================

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Briefly highlight yanked text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

-- ============================================================================
-- lazy.nvim bootstrap
-- ============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- Plugins
-- ============================================================================

require("lazy").setup({
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("monokai-pro").setup({ filter = "ristretto" })
      vim.cmd.colorscheme("monokai-pro")
    end,
  },

  "tpope/vim-sleuth",
  "tpope/vim-fugitive",

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "File [E]xplorer" },
    },
    opts = {
      filesystem = {
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = { width = 32 },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add          = { text = "+" },
        change       = { text = "~" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },

  {
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      local wk = require("which-key")
      wk.setup()
      wk.add({
        { "<leader>c", group = "[C]ode" },
        { "<leader>d", group = "[D]ocument" },
        { "<leader>r", group = "[R]ename" },
        { "<leader>s", group = "[S]earch" },
        { "<leader>w", group = "[W]orkspace" },
        { "<leader>g", group = "[G]it" },
      })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function() return vim.fn.executable("make") == 1 end,
      },
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = { require("telescope.themes").get_dropdown() },
        },
      })
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")

      local builtin = require("telescope.builtin")
      map("n", "<leader>sf", builtin.find_files,     { desc = "[S]earch [F]iles" })
      map("n", "<leader>sg", builtin.live_grep,      { desc = "[S]earch by [G]rep" })
      map("n", "<leader>sh", builtin.help_tags,      { desc = "[S]earch [H]elp" })
      map("n", "<leader>sw", builtin.grep_string,    { desc = "[S]earch current [W]ord" })
      map("n", "<leader>sd", builtin.diagnostics,    { desc = "[S]earch [D]iagnostics" })
      map("n", "<leader>sr", builtin.resume,         { desc = "[S]earch [R]esume" })
      map("n", "<leader>sk", builtin.keymaps,        { desc = "[S]earch [K]eymaps" })
      map("n", "<leader>sb", builtin.buffers,        { desc = "[S]earch [B]uffers" })
      map("n", "<leader><leader>", builtin.buffers,  { desc = "Find existing buffers" })
      map("n", "<leader>/", function()
        builtin.current_buffer_fuzzy_find(
          require("telescope.themes").get_dropdown({ winblend = 10, previewer = false })
        )
      end, { desc = "Fuzzy find in buffer" })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "j-hui/fidget.nvim", opts = {} },
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local bmap = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end
          local tb = require("telescope.builtin")
          bmap("gd",         tb.lsp_definitions,                 "[G]oto [D]efinition")
          bmap("gr",         tb.lsp_references,                  "[G]oto [R]eferences")
          bmap("gI",         tb.lsp_implementations,             "[G]oto [I]mplementation")
          bmap("<leader>D",  tb.lsp_type_definitions,            "Type [D]efinition")
          bmap("<leader>ds", tb.lsp_document_symbols,            "[D]ocument [S]ymbols")
          bmap("<leader>ws", tb.lsp_dynamic_workspace_symbols,   "[W]orkspace [S]ymbols")
          bmap("<leader>rn", vim.lsp.buf.rename,                 "[R]e[n]ame")
          bmap("<leader>ca", vim.lsp.buf.code_action,            "[C]ode [A]ction")
          bmap("K",          vim.lsp.buf.hover,                  "Hover Documentation")
          bmap("gD",         vim.lsp.buf.declaration,            "[G]oto [D]eclaration")
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend(
        "force", capabilities, require("cmp_nvim_lsp").default_capabilities()
      )

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
              diagnostics = { globals = { "vim" } },
            },
          },
        },
        gopls = {},
        pyright = {},
        ts_ls = {},
        ruby_lsp = {},
        bashls = {},
        dockerls = {},
        docker_compose_language_service = {},
        terraformls = {},
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
              schemas = { kubernetes = "*.k8s.{yml,yaml}" },
            },
          },
        },
        jsonls = {},
        marksman = {},
      }

      require("mason").setup()
      local ensure_installed = vim.tbl_keys(servers)
      vim.list_extend(ensure_installed, { "stylua", "shfmt", "prettier" })
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend(
              "force", {}, capabilities, server.capabilities or {}
            )
            require("lspconfig")[server_name].setup(server)
          end,
        },
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function() require("conform").format({ async = true, lsp_fallback = true }) end,
        desc = "[C]ode [F]ormat",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
      formatters_by_ft = {
        lua        = { "stylua" },
        python     = { "isort", "black" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        json       = { "prettier" },
        yaml       = { "prettier" },
        markdown   = { "prettier" },
        sh         = { "shfmt" },
        terraform  = { "terraform_fmt" },
        go         = { "goimports", "gofmt" },
      },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        build = (function()
          if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then return end
          return "make install_jsregexp"
        end)(),
      },
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      luasnip.config.setup({})

      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        completion = { completeopt = "menu,menuone,noinsert" },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"]     = cmp.mapping.select_next_item(),
          ["<C-p>"]     = cmp.mapping.select_prev_item(),
          ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
          ["<C-f>"]     = cmp.mapping.scroll_docs(4),
          ["<C-y>"]     = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete({}),
          ["<C-l>"]     = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then luasnip.expand_or_jump() end
          end, { "i", "s" }),
          ["<C-h>"]     = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then luasnip.jump(-1) end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
        },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "bash", "c", "diff", "dockerfile", "fish", "go", "gomod", "gosum",
        "hcl", "html", "javascript", "json", "lua", "luadoc", "markdown",
        "markdown_inline", "python", "query", "regex", "ruby", "rust",
        "terraform", "toml", "tsx", "typescript", "vim", "vimdoc", "yaml",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.install").prefer_git = true
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  { "numToStr/Comment.nvim", opts = {} },
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "monokai-pro",
        section_separators = "",
        component_separators = "|",
      },
    },
  },
})
