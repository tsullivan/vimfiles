require('base')
require('highlights')
require('maps')
require('plugins')

-- Enable automatic reading of files changed outside Neovim
vim.opt.autoread = true

-- Check for file changes when Neovim gains focus, enters a buffer, or cursor is idle
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  group = vim.api.nvim_create_augroup("CheckForExternalChanges", { clear = true }),
  callback = function()
    vim.cmd("checktime")
  end,
})

-- Optional: Display a message when a file is reloaded due to external changes
vim.api.nvim_create_autocmd({ "FileChangedShellPost" }, {
  group = vim.api.nvim_create_augroup("FileReloadNotification", { clear = true }),
  callback = function()
    vim.highlight.on_yank({higroup = "WarningMsg", timeout = 200}) -- Use WarningMsg highlight for visibility
    print("File changed on disk. Buffer reloaded.")
  end,
})
