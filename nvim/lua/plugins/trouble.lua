return {
  "folke/trouble.nvim",
  opts = {},
  cmd = "Trouble",
  keys = {
    {
      "<leader>tt",
      "<cmd>Trouble diagnostics toggle focus=true<cr>",
      desc = "Toggle [T]rouble",
    },

    { -- TODO: change this keymap
      "<leader>tn",
      "<cmd>Trouble diagnostics next jump=true<cr>",
      desc = "Go to [N]ext trouble",
    },

    { -- TODO: change this keymap
      "<leader>tp",
      "<cmd>Trouble diagnostics prev jump=true<cr>",
      desc = "Go to [P]revious trouble",
    },

    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=true<cr>",
      desc = "Toggle [C]ode [S]ymbols",
    },
  },
}
