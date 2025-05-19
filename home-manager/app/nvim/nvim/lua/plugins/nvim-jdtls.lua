return {
  'mfussenegger/nvim-jdtls',
  dependencies = { 'neovim/nvim-lspconfig' },
  ft = 'java',
  opts = function()
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

    local jdtls_config_dir = vim.fn.stdpath 'cache' .. '/jdtls/' .. project_name .. '/config'
    local jdtls_workspace_dir = vim.fn.stdpath 'cache' .. '/jdtls/' .. project_name .. '/workspace'

    return {
      cmd = {
        'jdtls',
        '-configuration',
        jdtls_config_dir,
        '-data',
        jdtls_workspace_dir,
      },
      root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' },
      settings = {
        java = {
          inlayHints = {
            parameterNames = {
              enabled = 'all',
            },
          },
        },
      },
    }
  end,
  config = function(_, opts)
    local has_blink, blink = pcall(require, 'blink.cmp')
    local capabilities = vim.tbl_deep_extend(
      'force',
      {},
      vim.lsp.protocol.make_client_capabilities(),
      has_blink and blink.get_lsp_capabilities() or {}
    )

    local function attach_jdtls()
      local config = {
        cmd = opts.cmd,
        root_dir = opts.root_dir,
        settings = opts.settings,
        capabilities = capabilities,
      }

      require('jdtls').start_or_attach(config)
    end

    -- Attach the jdtls for each java buffer. HOWEVER, this plugin loads
    -- depending on filetype, so this autocmd doesn't run for the first file.
    -- For that, we call directly below.
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'java',
      callback = attach_jdtls,
    })

    attach_jdtls()
  end,
}
