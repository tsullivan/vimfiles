local status, null_ls = pcall(require, "null-ls")
if not status then return end

-- Helper function to find Kibana workspace root
local function find_kibana_root(params)
  local util = require("lspconfig.util")

  -- First try to find workspace root by looking for kibana.d.ts
  local kibana_root = util.root_pattern("kibana.d.ts")(params.bufname)
  if kibana_root then
    return kibana_root
  end

  -- Fallback to looking for package.json
  return util.root_pattern("package.json")(params.bufname)
end

null_ls.setup({
    sources = {
        -- ESLint for diagnostics (warnings/errors)
        require("none-ls.diagnostics.eslint_d").with({
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
            prefer_local = "node_modules/.bin",
            cwd = find_kibana_root,
        }),

        -- ESLint for code actions (including autofix for individual rules)
        require("none-ls.code_actions.eslint_d").with({
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
            prefer_local = "node_modules/.bin",
            cwd = find_kibana_root,
        }),

        -- Prettier for formatting, respecting .prettierrc
        null_ls.builtins.formatting.prettier.with({
            filetypes = {
                "javascript",
                "javascriptreact",
                "typescript",
                "typescriptreact",
                "vue",
                "css",
                "scss",
                "less",
                "html",
                "json",
                "jsonc", -- For tsconfig.json, etc.
                "markdown",
                "yaml",
                "graphql",
                "svelte",
                "astro",
            },
            -- Use local `prettier` executable which will then automatically pick up .prettierrc
            prefer_local = "node_modules/.bin",
            cwd = find_kibana_root,
        }),
    },
})
