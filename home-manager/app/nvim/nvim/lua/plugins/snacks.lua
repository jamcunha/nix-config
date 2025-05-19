return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,

  opts = {
    bigfile = { enabled = true },
    -- indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    quickfile = { enabled = true },
  },

  -- stylua: ignore
  keys = {
    -- TODO: Find a way to have smart only in the root dir
    { '<leader>ff', function() Snacks.picker.files() end, },
    { '<leader>fw', function() Snacks.picker.grep_word() end, },
    { '<leader>fg', function() Snacks.picker.grep() end, },
    { '<leader>fd', function() Snacks.picker.diagnostics() end, },
    { '<leader><leader>', function() Snacks.picker.buffers() end, },
  },
}
