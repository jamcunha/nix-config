return {
  'saghen/blink.cmp',
  event = 'InsertEnter',

  -- optional: provides snippets for the snippet source
  dependencies = 'rafamadriz/friendly-snippets',

  version = '*',

  opts = {
    cmdline = { enabled = false },

    keymap = {
      preset = 'default',

      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<C-j>'] = { 'select_next', 'fallback' },

      ['<CR>'] = { 'select_and_accept', 'fallback' },

      ['<C-h>'] = { 'snippet_backward', 'fallback' },
      ['<C-l>'] = { 'snippet_forward', 'fallback' },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
  },
  opts_extend = { 'sources.default' },
}
