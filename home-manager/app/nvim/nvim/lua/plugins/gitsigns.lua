return {
  'lewis6991/gitsigns.nvim',

  keys = {
    { '<leader>ghb', '<cmd>Gitsigns blame_line<cr>' },
    { '<leader>ghB', '<cmd>Gitsigns blame<cr>' },
    { '<leader>ghd', '<cmd>Gitsigns diffthis<cr>' },
  },

  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
  },
}
