-- Use diagnostic functions for navigation
local diagnostic_opts = { noremap = true, silent = true }            -- Define common options for diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, diagnostic_opts) -- Map '[d' to go to the previous diagnostic
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, diagnostic_opts) -- Map ']d' to go to the next diagnostic

-- Map '<leader>q' to toggle the location list
vim.keymap.set('n', '<leader>q', function()
  vim.diagnostic.setloclist(nil)
end, { desc = 'Show diagnostics in location list' })

-- Map '<leader>Q' to toggle the location list with diagnostics for all buffers
vim.keymap.set('n', '<leader>Q', function()
  -- Get all diagnostics from all buffers
  local diagnostics = vim.diagnostic.get()

  -- Convert diagnostics to location list items
  local items = vim.diagnostic.toqflist(diagnostics)

  -- Set the location list with these items
  vim.fn.setloclist(0, items)

  -- Open the location list
  vim.cmd("lopen")
end, { desc = 'Show diagnostics from all buffers in location list' })

-- File Navigation with Telescope (wrapped in pcall to allow startup without telescope installed)
local telescope_ok, telescope = pcall(require, 'telescope')
local telescope_builtin_ok, telescope_builtin = pcall(require, 'telescope.builtin')

if telescope_ok and telescope_builtin_ok then
  local telescope_ext = telescope.extensions                                      -- Load Telescope's extensions
  local telescope_opts = { noremap = true }                                       -- Define common options for Telescope keymaps
  vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, telescope_opts) -- Map '<leader>ff' to find files
  vim.keymap.set('n', '<leader>fo', telescope_builtin.oldfiles, telescope_opts)   -- Map '<leader>fo' to find recently opened files
  vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, telescope_opts)    -- Map '<leader>fb' to list and switch between open buffers
  vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, telescope_opts)  -- Map '<leader>fg' to search text in all files

  -- Explorer
  -- Map '<leader>e' to open the Telescope file browser at the current file's directory
  vim.keymap.set('n', '<leader>e',
    function() telescope_ext.file_browser.file_browser { path = "%:p:h", select_buffer = true } end,
    { noremap = true, silent = true })
end

-- Documentation
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true }) -- Map 'K' to show LSP hover documentation

-- LSP mappings
local M = {} -- Initialize a table to return LSP-related functions
-- Define a function to be called when an LSP client attaches to a buffer
function M.on_attach_lsp(bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }       -- Define common options for buffer-local LSP keymaps
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)              -- Map 'gd' to go to the definition
  vim.keymap.set('n', '<leader>gy', vim.lsp.buf.type_definition, bufopts) -- Map '<leader>gy' to go to type definition
  vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, bufopts)  -- Map '<leader>gi' to go to implementation
  vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, bufopts)      -- Map '<leader>gr' to find references
  vim.keymap.set('n', '<leader>gn', vim.lsp.buf.rename, bufopts)          -- Map '<leader>gn' to rename a symbol
  vim.keymap.set('n', '<leader>cf', vim.lsp.buf.code_action, bufopts)     -- Map '<leader>cf' to show available code actions
  -- Map '<leader>fm' to format the current buffer using LSP formatting capabilities (e.g., ESLint via none-ls)
  vim.keymap.set('n', '<leader>fm', function()
    vim.lsp.buf.format { async = true }
  end, bufopts)
end

return M -- Return the table containing the on_attach_lsp function
