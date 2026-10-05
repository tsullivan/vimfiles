local gh = function(repo) return 'https://github.com/' .. repo end

-- Must be registered before vim.pack.add() so the hooks also fire on first install
vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('PackHooks', { clear = true }),
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then return end

    if name == 'telescope-fzf-native.nvim' then
      vim.system({ 'make' }, { cwd = ev.data.path }):wait()
    elseif name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
  end,
})

vim.pack.add({
  ---
  -- Color Themes
  ---
  gh('sainnhe/everforest'),
  gh('shaunsingh/nord.nvim'),
  gh('folke/tokyonight.nvim'),
  gh('ray-x/aurora'),
  gh('NLKNguyen/papercolor-theme'),
  gh('bluz71/vim-moonfly-colors'),
  gh('landersson/vim-blueberry'),
  { src = gh('catppuccin/nvim'), name = 'catppuccin' },
  gh('crusoexia/vim-monokai'),
  gh('morhetz/gruvbox'),
  gh('rebelot/kanagawa.nvim'),

  ---
  -- Language Server Protocol (LSP) & Completion
  ---
  gh('neovim/nvim-lspconfig'),             -- Standard configurations for LSP servers
  gh('mason-org/mason.nvim'),              -- Installs and manages LSP servers, formatters, etc.
  gh('mason-org/mason-lspconfig.nvim'),    -- Bridges Mason with nvim-lspconfig
  gh('nvim-lua/plenary.nvim'),             -- Common utility functions for Lua plugins
  gh('onsails/lspkind-nvim'),              -- Adds icons to completion items
  gh('hrsh7th/nvim-cmp'),                  -- Auto-completion engine
  gh('hrsh7th/cmp-buffer'),                -- nvim-cmp source: words from current buffer
  gh('hrsh7th/cmp-nvim-lsp'),              -- nvim-cmp source: LSP suggestions
  gh('nvimtools/none-ls.nvim'),            -- Integrates non-LSP tools (linters, formatters)
  gh('nvimtools/none-ls-extras.nvim'),
  gh('github/copilot.vim'),

  ---
  -- Utility & Core Enhancements
  ---
  gh('ruanyl/vim-gh-line'),            -- Generates GitHub permalinks for lines
  gh('editorconfig/editorconfig-vim'), -- Applies .editorconfig settings
  gh('tpope/vim-fugitive'),            -- Premier Git integration
  gh('inkarkat/vim-ingo-library'),     -- Dependency library for other Ingo Karkat plugins
  gh('inkarkat/vim-mark'),             -- Dependency library for other Ingo Karkat plugins
  gh('tpope/vim-unimpaired'),          -- Adds useful bracket mappings for common actions
  gh('jremmen/vim-ripgrep'),           -- Integrates ripgrep for fast searching
  gh('tpope/vim-eunuch'),              -- Unix commands as Vim commands
  gh('tpope/vim-sensible'),            -- Sets sensible Vim defaults
  gh('diepm/vim-rest-console'),        -- REST API client within Neovim

  ---
  -- Navigation & UI
  ---
  gh('nvim-telescope/telescope.nvim'),              -- Powerful fuzzy finder
  gh('nvim-telescope/telescope-file-browser.nvim'), -- Telescope extension for file browser
  gh('nvim-telescope/telescope-fzf-native.nvim'),   -- FZF performance booster for Telescope
  gh('akinsho/bufferline.nvim'),                    -- Displays open buffers as tabs
  gh('nvim-lualine/lualine.nvim'),                  -- Fast and customizable status line
  gh('arkav/lualine-lsp-progress'),                 -- Lualine extension for LSP progress indication
  gh('petertriho/nvim-scrollbar'),                  -- Adds a scrollbar to the editor

  ---
  -- Syntax & Treesitter
  ---
  { src = gh('nvim-treesitter/nvim-treesitter'), version = 'main' }, -- Next-gen syntax highlighting and parsing
  gh('windwp/nvim-ts-autotag'),                                      -- Auto-close and rename HTML/JSX/Vue tags
})
