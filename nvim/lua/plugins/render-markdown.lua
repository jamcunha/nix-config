return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  ft = { 'markdown' },
  opts = {
    code = {
      sign = false,
      width = 'block',
      right_pad = 1,
    },
    heading = {
      sign = false,
      icons = {},
    },
    checkbox = {
      custom = {},
    },
  },
}
