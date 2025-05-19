local M = {}

M.extra_setup = nil

M.extra_opts = {
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim', 'Snacks' },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

return M
