return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 30,
        signcolumn = 'yes'
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
      -- diagnostics = {
        -- enable = true,
        -- show_in_selection = true,
        -- show_on_dirs = true,
      -- }
    })

    vim.keymap.set('n', '<leader>tt', ':NvimTreeFindFile<CR>')
    vim.keymap.set('n', '<leader>to', ':NvimTreeToggle<CR>')

    vim.keymap.set('n', '<leader>tf', function()
      require("nvim-tree.api").tree.find_file({
        update_root = true,
        open = true,
        focus = false,
      })
    end)
  end
}
