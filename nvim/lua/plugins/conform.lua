return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },

  -- stylua: ignore
  keys = {
    { '<leader>f', function() require('conform').format { async = false } end, },
  },

  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local ignore_filetypes = { 'python' } -- formatting python is slow
      if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
        return nil
      end

      return {
        timeout_ms = 500,
        async = false,
        quite = false,
        lsp_format = 'fallback',
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      go = { 'goimports_reviser', 'gofumpt', 'golines' },
      python = { 'isort', 'black' },
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      nix = { 'alejandra' },

      javascript = { 'prettierd' },
      typescript = { 'prettierd' },
      javascriptreact = { 'prettierd' },
      typescriptreact = { 'prettierd' },
      svelte = { 'prettierd' },
      css = { 'prettierd' },
      html = { 'prettierd' },
    },
  },
}
