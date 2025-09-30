return {
  -- LSP Configuration & Plugins
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "folke/neodev.nvim",
      "nvimtools/none-ls.nvim",
      { "j-hui/fidget.nvim", opts = {} },
    }
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {},
      -- Explicitly exclude ts_ls from automatic setup
      automatic_installation = false,
      handlers = {
        -- Default handler for servers that don't need custom config
        function(server_name)
          -- Skip ts_ls, we handle it manually
          if server_name == "ts_ls" or server_name == "tsserver" then
            return
          end
          require("lspconfig")[server_name].setup({})
        end,
      },
    },
    dependencies = {
        { "williamboman/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-path",    -- Path completion
      "hrsh7th/cmp-npm",     -- npm dependencies completion
      "hrsh7th/cmp-buffer",  -- Buffer completion
      "hrsh7th/cmp-cmdline", -- Command line completion
      "David-Kunz/cmp-npm",  -- npm packages completion
    },
  },

  -- Copilot
  "github/copilot.vim",
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      "github/copilot.vim",
      "nvim-lua/plenary.nvim",
    },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
  },

  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },

  -- Git
  "lewis6991/gitsigns.nvim",
  "rhysd/conflict-marker.vim",

  -- Themes
  "navarasu/onedark.nvim",
  "rebelot/kanagawa.nvim",
  "sainnhe/everforest",
  "catppuccin/nvim",
  "bluz71/vim-moonfly-colors",

  -- UI Enhancements
  "nvim-lualine/lualine.nvim",
  "lukas-reineke/indent-blankline.nvim",
  "numToStr/Comment.nvim",
  "tpope/vim-sleuth",
  "jiangmiao/auto-pairs",

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = vim.fn.executable("make") == 1,
      },
    },
  },

}
