local M = {}

local userPlugins = require "custom.plugins"

M.plugins = {
  user = userPlugins,
  options = {
    lspconfig = {
      setup_lspconf = "custom.lsp_config",
    },
  },
}

return M
