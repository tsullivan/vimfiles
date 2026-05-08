return require('packer').startup(function(use)
  -- Plugin Manager
  use { 'wbthomason/packer.nvim' } -- Manages Neovim plugins

  ---
  -- Color Themes
  ---
  use { 'sainnhe/everforest' }
  use { 'shaunsingh/nord.nvim' }
  use { 'folke/tokyonight.nvim' }
  use { 'ray-x/aurora' }
  use { 'NLKNguyen/papercolor-theme' }
  use { 'bluz71/vim-moonfly-colors' }
  use { 'landersson/vim-blueberry' }
  use { 'catppuccin/nvim' }
  use { 'crusoexia/vim-monokai' }
  use { 'morhetz/gruvbox' }
  use { 'rebelot/kanagawa.nvim' }

  ---
  -- Language Server Protocol (LSP) & Completion
  ---
  use { 'neovim/nvim-lspconfig' }                                                  -- Standard configurations for LSP servers
  use { 'williamboman/mason.nvim' }                                                -- Installs and manages LSP servers, formatters, etc.
  use { 'williamboman/mason-lspconfig.nvim' }                                      -- Bridges Mason with nvim-lspconfig
  use { 'nvim-lua/plenary.nvim' }                                                  -- Common utility functions for Lua plugins
  use { 'onsails/lspkind-nvim' }                                                   -- Adds icons to completion items
  use { 'hrsh7th/nvim-cmp' }                                                       -- Auto-completion engine
  use { 'hrsh7th/cmp-buffer' }                                                     -- nvim-cmp source: words from current buffer
  use { 'hrsh7th/cmp-nvim-lsp' }                                                   -- nvim-cmp source: LSP suggestions
  use { 'nvimtools/none-ls.nvim', requires = { 'nvimtools/none-ls-extras.nvim' } } -- Integrates non-LSP tools (linters, formatters)
  use { 'github/copilot.vim' }

  ---
  -- Utility & Core Enhancements
  ---
  use { 'ruanyl/vim-gh-line' }            -- Generates GitHub permalinks for lines
  use { 'editorconfig/editorconfig-vim' } -- Applies .editorconfig settings
  use { 'tpope/vim-fugitive' }            -- Premier Git integration
  use { 'inkarkat/vim-ingo-library' }     -- Dependency library for other Ingo Karkat plugins
  use { 'inkarkat/vim-mark' }             -- Dependency library for other Ingo Karkat plugins
  use { 'tpope/vim-unimpaired' }          -- Adds useful bracket mappings for common actions
  use { 'jremmen/vim-ripgrep' }           -- Integrates ripgrep for fast searching
  use { 'tpope/vim-eunuch' }              -- Unix commands as Vim commands
  use { 'tpope/vim-sensible' }            -- Sets sensible Vim defaults
  use { 'diepm/vim-rest-console' }        -- REST API client within Neovim

  ---
  -- Navigation & UI
  ---
  use { 'nvim-telescope/telescope.nvim' }                                          -- Powerful fuzzy finder
  use { 'nvim-telescope/telescope-file-browser.nvim' }                             -- Telescope extension for file browser
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }                 -- FZF performance booster for Telescope
  use { 'akinsho/bufferline.nvim' }                                                -- Displays open buffers as tabs
  use { 'nvim-lualine/lualine.nvim', requires = { 'arkav/lualine-lsp-progress' } } -- Fast and customizable status line
  use { 'arkav/lualine-lsp-progress' }                                             -- Lualine extension for LSP progress indication
  use { 'petertriho/nvim-scrollbar' }                                              -- Adds a scrollbar to the editor

  ---
  -- Syntax & Treesitter
  ---
  use {
    'nvim-treesitter/nvim-treesitter', -- Next-gen syntax highlighting and parsing
    run = ':TSUpdate'                  -- Command to update Treesitter parsers after installation/update
  }
end)
