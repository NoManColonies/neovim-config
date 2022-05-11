return {
   ["kyazdani42/nvim-tree.lua"] = {
      setup = function()
         local map = require("core.utils").map
         map("n", "<C-n>", "<cmd> :NvimTreeToggle <CR>")
         map("n", "<leader>m", "<cmd> :NvimTreeFocus <CR>")
      end,
   },
   ["jose-elias-alvarez/null-ls.nvim"] = {
      after = "nvim-lspconfig",
      config = function()
         require("custom.null_ls").setup()
      end,
   },
   ["nvim-lua/lsp_extensions.nvim"] = {
      before = "nvim-lspconfig",
   },
   ["andweeb/presence.nvim"] = {},
   ["editorconfig/editorconfig-vim"] = {},
   ["mfussenegger/nvim-dap"] = {
      setup = function()
         local dap = require "dap"
         dap.set_log_level "ERROR"
         dap.adapters.node2 = {
            type = "executable",
            command = "node",
            args = {
               os.getenv "HOME" .. "/Documents/experimental-workspace/vscode-node-debug2/out/src/nodeDebug.js",
               "--inspect",
            },
         }
         dap.configurations.javascript = {
            {
               name = "Launch",
               type = "node2",
               request = "launch",
               program = "${file}",
               cwd = vim.fn.getcwd(),
               sourceMaps = true,
               protocol = "inspector",
               console = "integratedTerminal",
            },
            {
               -- For this to work you need to make sure the node process is started with the `--inspect` flag.
               name = "Attach to process",
               type = "node2",
               request = "attach",
               processId = require("dap.utils").pick_process,
            },
         }
         dap.configurations.typescript = {
            {
               name = "Launch",
               type = "node2",
               request = "launch",
               program = "${workspaceFolder}/dist/index.js",
               cwd = vim.fn.getcwd(),
               sourceMaps = true,
               skipFiles = { "<node_internals>/**" },
               protocol = "inspector",
               console = "integratedTerminal",
               outFiles = { "${workspaceFolder}/**/*.js" },
               resolveSourceMapLocations = {
                  "${workspaceFolder}/**",
                  "!**/node_modules/**",
               },
            },
            {
               -- For this to work you need to make sure the node process is started with the `--inspect` flag.
               name = "Attach to process",
               type = "node2",
               request = "attach",
               processId = require("dap.utils").pick_process,
            },
         }
      end,
   },
   ["nvim-telescope/telescope-dap.nvim"] = {
      after = { "telescope.nvim", "nvim-dap" },
      config = function()
         require("telescope").load_extension "dap"
      end,
   },
   ["anuvyklack/nvim-keymap-amend"] = {},
   ["anuvyklack/pretty-fold.nvim"] = {
      requires = "anuvyklack/nvim-keymap-amend", -- only for preview
      config = function()
         require("pretty-fold").setup()
         require("pretty-fold.preview").setup()
      end,
   },
}
