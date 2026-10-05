local maps_ok, maps = pcall(require, 'maps')
local on_attach_lsp = maps_ok and maps.on_attach_lsp or function() end

-- Capabilities (with nvim-cmp integration if available)
local cmp_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
local capabilities = cmp_lsp_ok and cmp_nvim_lsp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()

-- Common on_attach via LspAttach autocommand
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- Enable omnifunc completion
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Set up user mappings (from your maps module)
    on_attach_lsp(bufnr)

    -- TypeScript: Register OrganizeImports command
    if client and (client.name == "ts_ls") then
      vim.api.nvim_buf_create_user_command(bufnr, "OrganizeImports", function()
        vim.lsp.buf.execute_command({
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(0) },
        })
      end, { desc = "Organize Imports using TypeScript LSP" })
    end
  end,
})

-- TypeScript/JavaScript LSP
vim.lsp.config.ts_ls = {
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/typescript-language-server", "--stdio" },
  capabilities = capabilities,
  root_markers = { 'package.json', 'tsconfig.json', '.git' },
  single_file_support = false,
}

vim.api.nvim_create_user_command('LspRestart', function(opts)
  local name = opts.args ~= '' and opts.args or nil
  local clients = vim.lsp.get_clients({ bufnr = 0, name = name })
  vim.lsp.stop_client(clients)
  vim.cmd('e')
end, { nargs = '?', desc = 'Restart LSP client(s) for current buffer' })

-- Enable the LSP servers
vim.lsp.enable('ts_ls')
