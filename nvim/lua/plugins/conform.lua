-- Autoformat

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "[F]ormat buffer",
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- TODO: maybe add a list of filetypes to format on save instead of ignoring
      local ignore_filetypes = { "python", "c", "cpp", "h", "hpp" }
      if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
        return nil
      end

      return {
        timeout_ms = 500,
        lsp_format = "fallback",
      }
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      go = { "goimports_reviser", "gofumpt", "golines" },
      -- Conform can also run multiple formatters sequentially
      python = { "isort", "black" },
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  },
}
