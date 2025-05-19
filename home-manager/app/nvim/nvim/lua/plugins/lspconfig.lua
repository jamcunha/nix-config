return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    { 'j-hui/fidget.nvim', opts = {} },
  },

  opts = {
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = 'if_many',
        prefix = '●',
      },
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = ' ',
          [vim.diagnostic.severity.WARN] = ' ',
          [vim.diagnostic.severity.HINT] = ' ',
          [vim.diagnostic.severity.INFO] = ' ',
        },
      },
    },
  },

  config = function(_, opts)
    local lspconfig = require 'lspconfig'

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func)
          vim.keymap.set('n', keys, func, { buffer = event.buf, silent = true })
        end

        local have_snacks, _ = pcall(require, 'snacks')

        -- stylua: ignore
        if have_snacks then
          map('gd', function() Snacks.picker.lsp_definitions() end)
          map('gD', function() Snacks.picker.lsp_declarations() end)
          map('<leader>D', function() Snacks.picker.lsp_type_definitions() end)
          map('gI', function() Snacks.picker.lsp_implementations() end)
          map('gr', function() Snacks.picker.lsp_references() end)
          map('<leader>ds', function() Snacks.picker.lsp_symbols() end)
          map('<leader>ws', function() Snacks.picker.lsp_workspace_symbols() end)
        else
          map('gd', function() vim.lsp.buf.definition() end)
          map('gD', function() vim.lsp.buf.declaration() end)
          map('<leader>D', function() vim.lsp.buf.type_definition() end)
          map('gI', function() vim.lsp.buf.implementation() end)
          map('gr', function() vim.lsp.buf.references() end)
          map('<leader>ds', function() vim.lsp.buf.document_symbol() end)
          map('<leader>ws', function() vim.lsp.buf.workspace_symbol() end)
        end

        -- stylua: ignore
        map('K', function() vim.lsp.buf.hover() end)
        -- stylua: ignore
        map('<leader>rn', function() vim.lsp.buf.rename() end)
        -- stylua: ignore
        map('<leader>ca', function() vim.lsp.buf.code_action() end)

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end)
        end
      end,
    })

    if vim.fn.has 'nvim-0.10.0' == 0 then
      if type(opts.diagnostics.signs) ~= 'boolean' then
        for severity, icon in pairs(opts.diagnostics.signs.text) do
          local name = vim.diagnostic.severity[severity]:lower():gsub('^%l', string.upper)
          name = 'DiagnosticSign' .. name
          vim.fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
        end
      end
    end

    if type(opts.diagnostics.virtual_text) == 'table' and opts.diagnostics.virtual_text.prefix == 'icons' then
      opts.diagnostics.virtual_text.prefix = vim.fn.has 'nvim-0.10.0' == 0 and '●'
        or function(diagnostic)
          local icons = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.HINT] = ' ',
            [vim.diagnostic.severity.INFO] = ' ',
          }

          for d, icon in pairs(icons) do
            if diagnostic.severity == d then
              return icon
            end
          end
        end
    end

    vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    local has_blink, blink = pcall(require, 'blink.cmp')
    local capabilities = vim.tbl_deep_extend(
      'force',
      {},
      vim.lsp.protocol.make_client_capabilities(),
      has_blink and blink.get_lsp_capabilities() or {}
    )

    local servers = {
      'lua_ls',
      'nixd',
      'gopls',
      'clangd',
      'basedpyright',
      'marksman',

      'vtsls',
      'tailwindcss',

      'jdtls',
    }

    for _, server in ipairs(servers) do
      if server ~= 'jdtls' then
        local server_opts = {
          capabilities = capabilities,
        }

        local ok, settings = pcall(require, 'lspconfig.' .. server)
        if ok then
          if settings.extra_setup ~= nil then
            settings.extra_setup()
          end
          server_opts = vim.tbl_deep_extend('force', settings.extra_opts, server_opts)
        end

        lspconfig[server].setup(server_opts)
      end
    end
  end,
}
