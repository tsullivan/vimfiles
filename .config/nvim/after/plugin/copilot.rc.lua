-- GitHub Copilot (github/copilot.vim)
-- Bail out cleanly if the plugin isn't available (e.g. before :PackerSync).
if vim.fn.exists(':Copilot') == 0 then return end

---------------------------------------------------------------------------
-- Settings
---------------------------------------------------------------------------
-- Disable the default <Tab> -> accept mapping so <Tab> stays free for
-- indentation / other completion engines. We bind accept to <C-J> below.
vim.g.copilot_no_tab_map = true

-- Filetypes Copilot is allowed to run in. `["*"] = true` enables it
-- everywhere except the buffers explicitly disabled here.
vim.g.copilot_filetypes = {
  ['*'] = true,
  gitcommit = false,
  gitrebase = false,
  hgcommit = false,
  markdown = true, -- enabled by default upstream, listed here so it's easy to flip
}

---------------------------------------------------------------------------
-- Insert-mode keymaps (suggestion handling)
---------------------------------------------------------------------------
-- copilot#Accept / AcceptWord / AcceptLine must use expr maps with
-- replace_keycodes = false (they return the literal text to insert).
local expr = { expr = true, replace_keycodes = false, silent = true, desc = nil }

-- Accept the whole suggestion. Falls back to a normal <CR> when there is none.
vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")',
  vim.tbl_extend('force', expr, { desc = 'Copilot: accept suggestion' }))

-- Accept just the next word of the suggestion.
vim.keymap.set('i', '<C-L>', 'copilot#AcceptWord()',
  vim.tbl_extend('force', expr, { desc = 'Copilot: accept word' }))

-- Accept just the next line of the suggestion.
-- NOTE: <C-K> normally starts digraph entry in insert mode; remove this map
-- if you rely on digraphs.
vim.keymap.set('i', '<C-K>', 'copilot#AcceptLine()',
  vim.tbl_extend('force', expr, { desc = 'Copilot: accept line' }))

-- Cycle / control suggestions. These call the Copilot functions directly so
-- they work regardless of terminal Meta-key handling (the upstream defaults
-- use <M-]> / <M-[> / <M-\> which are unreliable in some macOS terminals).
local cmd_opts = { silent = true }
vim.keymap.set('i', '<C-.>', '<Cmd>call copilot#Next()<CR>',
  vim.tbl_extend('force', cmd_opts, { desc = 'Copilot: next suggestion' }))
vim.keymap.set('i', '<C-,>', '<Cmd>call copilot#Previous()<CR>',
  vim.tbl_extend('force', cmd_opts, { desc = 'Copilot: previous suggestion' }))
vim.keymap.set('i', '<C-\\>', '<Cmd>call copilot#Suggest()<CR>',
  vim.tbl_extend('force', cmd_opts, { desc = 'Copilot: trigger suggestion' }))
vim.keymap.set('i', '<C-]>', '<Cmd>call copilot#Dismiss()<CR>',
  vim.tbl_extend('force', cmd_opts, { desc = 'Copilot: dismiss suggestion' }))

-- Upstream Meta-key defaults are kept too, in case your terminal sends them
-- (iTerm2 "Option as Meta", kitty, wezterm, Ghostty, etc.):
--   <M-]> next   <M-[> previous   <M-\> suggest   <M-Right> accept word

---------------------------------------------------------------------------
-- Normal-mode commands (panel / status / toggle)
---------------------------------------------------------------------------
local nopts = { silent = true }
vim.keymap.set('n', '<leader>cp', '<Cmd>Copilot panel<CR>',
  vim.tbl_extend('force', nopts, { desc = 'Copilot: open suggestion panel' }))
vim.keymap.set('n', '<leader>cs', '<Cmd>Copilot status<CR>',
  vim.tbl_extend('force', nopts, { desc = 'Copilot: status' }))
vim.keymap.set('n', '<leader>ce', '<Cmd>Copilot enable<CR>',
  vim.tbl_extend('force', nopts, { desc = 'Copilot: enable' }))
vim.keymap.set('n', '<leader>cd', '<Cmd>Copilot disable<CR>',
  vim.tbl_extend('force', nopts, { desc = 'Copilot: disable' }))
