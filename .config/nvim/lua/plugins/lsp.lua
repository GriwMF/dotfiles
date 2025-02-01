return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
      ensure_installed = {
        "ruby_lsp",
        "lua_ls",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require("lspconfig")
      lspconfig.ruby_lsp.setup({
        capabilities = capabilities
      })
      lspconfig.lua_ls.setup({})

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})

      -- -- Custom keymap for fixing the entire file with RuboCop
      -- vim.keymap.set("n", "<leader>rf", function()
        -- -- Save the current buffer
        -- vim.cmd('write')
-- 
        -- -- Get the absolute file path
        -- local filepath = vim.fn.expand('%:p')
-- 
        -- -- Run RuboCop autocorrect on the saved file
        -- vim.cmd('!rubocop --autocorrect ' .. filepath)
-- 
        -- -- Reload the file to reflect changes
        -- -- vim.cmd('edit')
      -- end, { desc = "RuboCop Autocorrect Current File" })
    end,
  },
}
