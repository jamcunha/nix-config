local M = {}

M.extra_setup = nil

M.extra_opts = {
  settings = {
    gopls = {
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
      semanticTokens = true,

      analyses = {
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },

      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },

      gofumpt = true,
    },
  },

  -- Not sure if it works
  -- workaround for gopls not supporting semanticTokensProvider
  -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
  on_attach = function(client, _)
    if not client.server_capabilities.semanticTokensProvider then
      local semantics = client.config.capabilities.textDocument.semanticTokens
      client.server_capabilities.semanticTokensProvider = {
        full = true,
        legend = {
          tokenTypes = semantics.tokenTypes,
          tokenModifiers = semantics.tokenModifiers,
        },
      }
    end
  end,
}

return M
