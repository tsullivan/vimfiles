vim.cmd("autocmd!")

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.wo.number = true

vim.opt.smartcase = true
vim.opt.hidden = true
vim.opt.fileformat = 'unix'
vim.opt.title = true
vim.opt.ttyfast = true
--- vim.opt.textwidth = 111
vim.opt.textwidth = 0 -- unlimited
vim.opt.sw = 2
vim.opt.ts=2
vim.opt.sts=2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.showcmd = true
vim.opt.number = true
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wildignore:append { '*/.git/*,*/node_modules,*/build,*/target' }

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("MarkPalette extended")
  end,
})
