local status, ts = pcall(require, "nvim-treesitter")
if (not status) then return end

ts.install {
  "javascript",
  "typescript",
  "tsx",
  "json",
  "yaml",
  "css",
  "html",
  "lua",
  "vue",
  "markdown",
  "markdown_inline",
}

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
  callback = function(args)
    if not pcall(vim.treesitter.start, args.buf) then return end
    local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
    if lang and vim.treesitter.query.get(lang, "indents") then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
