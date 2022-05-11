local M = {}

M.setup_lsp = function(attach, capabilities)
   local lspconfig = require "lspconfig"

   local servers = {
      "tsserver",
      "sumneko_lua",
      "gopls",
      "rust_analyzer",
      "pyright",
      "volar",
      "eslint",
      "stylelint_lsp",
      "jsonls",
      "dotls",
      "bashls",
      "cssls",
      "cssmodules_ls",
   }

   for _, lsp in ipairs(servers) do
      local opts = {
         on_attach = attach,
         capabilities = capabilities,
         flags = {
            debounce_text_changes = 150,
         },
         settings = {},
      }

      -- basic example to edit lsp server's options, disabling tsserver's inbuilt formatter
      if lsp == "tsserver" then
         opts.on_attach = function(client, bufnr)
            client.resolved_capabilities.document_formatting = false
            vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})
         end
      end

      if lsp == "sumneko_lua" then
         opts.settings = {
            Lua = {
               diagnostics = {
                  globals = { "vim" },
               },
               workspace = {
                  library = {
                     [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                     [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                  },
                  maxPreload = 100000,
                  preloadFileSize = 10000,
               },
               telemetry = {
                  enable = false,
               },
            },
         }
      end

      if lsp == "gopls" then
         opts.settings = {
            gopls = {
               analyses = {
                  unusedparams = true,
               },
               staticcheck = true,
            },
         }
      end

      if lsp == "rust_analyzer" then
         opts.settings = {
            ["rust-analyzer"] = {
               checkOnSave = {
                  command = "clippy",
               },
               assist = {
                  importGranularity = "module",
                  importPrefix = "by_self",
               },
               cargo = {
                  loadOutDirsFromCheck = true,
               },
               procMacro = {
                  enable = true,
               },
            },
         }
      end

      if lsp == "pyright" then
         opts.settings = {
            puthon = {
               analysis = {
                  autoSearchPaths = true,
                  diagnosticMode = "workspace",
                  useLibraryCodeForTypes = true,
               },
            },
         }
      end
      lspconfig[lsp].setup(opts)
   end
end

return M
