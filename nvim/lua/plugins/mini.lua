-- Collection of various small independent plugins/modules

return {
  "echasnovski/mini.nvim",
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    require("mini.ai").setup({ n_lines = 500 })

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require("mini.surround").setup()

    -- Comment lines
    --
    -- - gc   - Toggle [C]omment
    -- - gcip - Toggle [C]omment [I]nner [P]aragraph
    -- - gcc  - Toggle [C]omment [C]urrent line
    -- - dgc  - [D]elete [C]omment
    require("mini.comment").setup()

    -- Highlight patterns (maybe change with NVChad/nvim-colorizer.lua)
    local hipatterns = require "mini.hipatterns"
    hipatterns.setup({
      highlighters = {
        hex_color = hipatterns.gen_highlighter.hex_color()
      }
    })

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require("mini.statusline")
    -- set use_icons to true if you have a Nerd Font
    statusline.setup({ use_icons = vim.g.have_nerd_font })

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return "%2l:%-2v"
    end

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}