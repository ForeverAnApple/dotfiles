local cmp = require "cmp"

return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = { "rust" },
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      require "configs.rustaceanvim"
    end
  },

  -- test new blink
  { import = "nvchad.blink.lazyspec" },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = {
        width = 25,
      },
    },
  },
  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc",
       "html", "css"
  		},
  	},
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    'saecki/crates.nvim',
    ft = {"toml"},
    config = function(_, opts)
      local crates = require('crates')
      crates.setup(opts)
      require('cmp').setup.buffer({
        sources = { { name = "crates" }}
      })
      crates.show()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local M = require "plugins.configs.cmp"
      M.completion.completeopt = "menu,menuone,noselect"
      M.mapping["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = false,
      }
      table.insert(M.sources, {name = "crates"})
      return M
    end,
  },

  -- Claude Code
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>cc", "<cmd>ClaudeCode<CR>", mode = { "n", "t" }, desc = "Toggle Claude Code" },
      { "<leader>cC", "<cmd>ClaudeCodeContinue<CR>", desc = "Continue conversation" },
      { "<leader>cR", "<cmd>ClaudeCodeResume<CR>", desc = "Resume conversation" },
      { "<leader>cV", "<cmd>ClaudeCodeVerbose<CR>", desc = "Verbose mode" },
    },
    opts = {
      window = {
        position = "vertical",
        split_ratio = 0.3,
        enter_insert = true,
        hide_numbers = true,
        hide_signcolumn = true,
      },
      keymaps = {
        toggle = {
          normal = false,
          terminal = false,
        },
        window_navigation = true,
      },
    },
  },

  -- Opencode
  {
    "NickvanDyke/opencode.nvim",

    dependencies = {
      -- Recommended for `ask()` and `select()`.
      -- Required for `snacks` provider.
      ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
      { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },

    -- Lazy load on these keymaps
    keys = {
      -- Core functionality
      { "<leader>oa", function() require("opencode").ask("", { submit = true }) end, mode = { "n", "x" }, desc = "Ask opencode" },
      { "<leader>os", function() require("opencode").select() end, mode = { "n", "x" }, desc = "Execute opencode action…" },
      { "<leader>oo", function() require("opencode").toggle() end, mode = { "n", "t" }, desc = "Toggle opencode" },
      { "go", function() return require("opencode").operator("@this ") end, mode = { "n", "x" }, expr = true, desc = "Add range to opencode" },
      { "goo", function() return require("opencode").operator("@this ") .. "_" end, mode = "n", expr = true, desc = "Add line to opencode" },
      { "<leader>ou", function() require("opencode").command("session.half.page.up") end, mode = "n", desc = "opencode half page up" },
      { "<leader>od", function() require("opencode").command("session.half.page.down") end, mode = "n", desc = "opencode half page down" },
      -- Prompts
      { '<leader>oA', function() require('opencode').ask('@file ') end, desc = 'Ask opencode about current file', mode = { 'n', 'v' }, },
      { '<leader>on', function() require('opencode').command('/new') end, desc = 'New session', },
      { '<leader>oe', function() require('opencode').prompt('Explain @cursor and its context') end, desc = 'Explain code near cursor' },
      { '<leader>or', function() require('opencode').prompt('Review @file for correctness and readability') end, desc = 'Review file', },
      { '<leader>of', function() require('opencode').prompt('Fix these @diagnostics') end, desc = 'Fix errors', },
      { '<leader>oO', function() require('opencode').prompt('Optimize @selection for performance and readability') end, desc = 'Optimize selection', mode = 'v', },
      { '<leader>oD', function() require('opencode').prompt('Add documentation comments for @selection') end, desc = 'Document selection', mode = 'v', },
      { '<leader>ot', function() require('opencode').prompt('Add tests for @selection') end, desc = 'Test selection', mode = 'v', },
    },

    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Enable blink.cmp completion in ask input
        ask = {
          blink_cmp_sources = { "opencode", "buffer" },
        },

        -- Custom prompts (including Rust-specific)
        prompts = {
          unsafe_review = { prompt = "Review @this for unsafe Rust correctness and potential UB", submit = true },
          cargo_fix = { prompt = "Suggest fixes for these Cargo/clippy warnings: @diagnostics", submit = true },
          refactor = { prompt = "Refactor @this for better readability and maintainability", submit = true },
          types = { prompt = "Add or improve type annotations for @this", submit = true },
        },

        -- Picker layout
        select = {
          snacks = {
            layout = {
              preset = "vscode",
            },
          },
        },

        -- Provider settings (change 'enabled' to switch: "snacks", "kitty", "terminal")
        provider = {
          enabled = "snacks", -- Currently active provider
          snacks = {
            win = {
              position = "right",
              width = 0.35,
            },
          },
        },
      }

      -- Required for `opts.events.reload`.
      vim.o.autoread = true
    end,
  },
}

