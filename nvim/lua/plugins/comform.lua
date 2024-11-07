-- Autoformat

return {
    "stevearc/conform.nvim",
    lazy = false,
    keys = {
        {
            "<leader>f",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            mode = "",
            desc = "[F]ormat buffer",
        },
    },
    opts = {
        notify_on_error = false,
        format_on_save = function(bufnr)
            local disable_filetypes = { "c", "cpp", "h", "hpp", "python" }
            if vim.tbl_contains(disable_filetypes, vim.bo[bufnr].filetype) then
                return nil
            end

            -- Enable "format_on_save lsp_fallback" for specific filetypes
            local enable_filetypes = { "go" }
            return {
                timeout_ms = 500,
                lsp_fallback = enable_filetypes[vim.bo[bufnr].filetype],
            }
        end,
        formatters_by_ft = {
            lua = { "stylua" },
            go = { "goimports_reviser", "gofumpt", "golines" },
            -- Conform can also run multiple formatters sequentially
            python = { "isort", "black" },
            --
            -- You can use a sub-list to tell conform to run *until* a formatter
            -- is found.
            -- javascript = { { "prettierd", "prettier" } },
        },
    },
}
