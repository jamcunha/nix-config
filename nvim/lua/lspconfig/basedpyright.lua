local M = {}

M.extra_setup = nil

M.extra_opts = {
  settings = {
    basedpyright = {
      disableOrganizeImports = true, -- isort takes care of organizing imports
    },
  },
}

return M
