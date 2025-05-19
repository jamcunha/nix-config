local M = {}

M.extra_setup = function()
  -- copy typescript settings to javascript
  M.extra_opts.settings.javascript =
    vim.tbl_deep_extend('force', {}, M.extra_opts.settings.typescript, M.extra_opts.settings.javascript or {})
end

M.extra_opts = {
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.jsx',
  },
  settings = {
    complete_function_calls = true,
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        maxInlayHintLength = 30,
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
    typescript = {
      updateImportsOnFileMove = { enabled = 'always' },
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = {
        enumMembers = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = 'literals' },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = true },
      },
    },
  },

  on_attach = function(_, bufnr)
    local map = function(keys, func)
      vim.keymap.set('n', keys, func, { buffer = bufnr, noremap = true, silent = true })
    end

    map('gR', function()
      require('trouble').open {
        mode = 'lsp_command',
        params = {
          command = 'typescript.goToSourceDefinition',
          arguments = { vim.uri_from_bufnr(0) },
        },
      }
    end)

    map('<leader>co', function()
      vim.lsp.buf.code_action {
        apply = true,
        context = { only = { 'source.organizeImports' }, diagnostics = {} },
      }
    end)

    map('<leader>cM', function()
      vim.lsp.buf.code_action {
        apply = true,
        context = { only = { 'source.addMissingImports.ts' }, diagnostics = {} },
      }
    end)

    map('<leader>cu', function()
      vim.lsp.buf.code_action {
        apply = true,
        context = { only = { 'source.removeUnused.ts' }, diagnostics = {} },
      }
    end)
  end,
}

return M
