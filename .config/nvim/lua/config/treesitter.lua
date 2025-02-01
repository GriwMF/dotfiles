require('nvim-treesitter.configs').setup({
  ensure_installed = {"go", "lua", "rust", "vim", "vimdoc", "javascript", "ruby"},
  auto_install = true,
  highlight = {
    enable = true,
    disable = {},
  },
  indent = { enable = true },

  -- Additional Tree-sitter modules and configurations...
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<leader>ss",
      node_incremental = "<leader>si",
      scope_incremental = "<leader>sc",
      node_decremental = "<leader>sd",
    },
  },
})
