local M = {}

M.extra_setup = nil

M.extra_opts = {
  settings = {
    nixd = {
      nixpkgs = {
        expr = 'import <nixpkgs> { }',
      },
      formatting = {
        command = { 'alejandra' },
      },
      options = {
        nixos = {
          expr = vim.fn.filereadable '/etc/NIXOS'
              and '(builtins.getFlake "' .. vim.fn.expand '$HOME/nix-config' .. '").nixosConfigurations.' .. vim.fn.hostname() .. '.options'
            or '',
        },

        -- With home-manager it's not working for now
        -- home_manager = {
        --   expr = '(builtins.getFlake "'
        --     .. vim.fn.expand '$HOME/nix-config'
        --     .. '").homeConfigurations.'
        --     .. vim.fn.hostname()
        --     .. '.options',
        -- },
      },
    },
  },
}

return M
