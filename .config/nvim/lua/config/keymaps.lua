vim.keymap.set('n', '<esc>', ':nohlsearch<CR>', { noremap = true, silent = true })

-- Copy file name
vim.keymap.set('n', '<leader>cn', ':let @+=expand("%:t")<CR>')
-- Copy relative, absolute and directory path
vim.keymap.set('n', '<leader>cr', ':let @+=expand("%")<CR>')
vim.keymap.set('n', '<leader>cp', ':let @+=expand("%:p")<CR>')
vim.keymap.set('n', '<leader>cd', ':let @+=expand("%:p:h")<CR>')
-- Copy file name with line number
vim.keymap.set('n', '<leader>cln', ':let @+=expand("%:t").":".line(".")<CR>')
-- Copy relative, absolute and directory path with line number
vim.keymap.set('n', '<leader>clr', ':let @+=expand("%").":".line(".")<CR>')
vim.keymap.set('n', '<leader>clp', ':let @+=expand("%:p").":".line(".")<CR>')
vim.keymap.set('n', '<leader>cld', ':let @+=expand("%:p:h").":".line(".")<CR>')

-- Move lines up and down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- Copilot
vim.keymap.set('i', '<c-L>', '<Plug>(copilot-accept-word)')
vim.keymap.set('i', '<c-]>', '<Plug>(copilot-next)')
-- vim.keymap.set('i', '<c-J>', 'copilot#Accept("\\<CR>")', {
--   expr = true,
--   replace_keycodes = false
-- })

-- LSP
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, {})
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})

-- Add a key binding to toggle the diagnostic display mode
vim.keymap.set("n", "<leader>tl", function()
  local virtual_lines_enabled = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = virtual_lines_enabled, virtual_text = not virtual_lines_enabled })
end, { desc = "Toggle LSP Lines" })

-- Add a keymap to toggle inlay hints
vim.keymap.set('n', '<leader>tih', function()
  local current = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
  vim.lsp.inlay_hint.enable(not current, { bufnr = 0 })
  print("Inlay hints: " .. (not current and "ON" or "OFF"))
end, { desc = "Toggle inlay hints" })

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fhf', function()
  builtin.find_files({
    hidden = true
  })
end, { desc = 'Telescope find files including hidden files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, {})

-- Nvim tree
vim.keymap.set('n', '<leader>tt', ':NvimTreeFindFile<CR>')
vim.keymap.set('n', '<leader>to', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<leader>tf', function()
  require("nvim-tree.api").tree.find_file({
    update_root = true,
    open = true,
    focus = false,
  })
end)

-- Tests with vim-rails
vim.keymap.set('n', '<leader>rt', ':.Rails<CR>')
vim.keymap.set('n', '<leader>rqt', ':.Rails!<CR>')
vim.keymap.set('n', '<leader>rs', ':Rails<CR>')
vim.keymap.set('n', '<leader>rqs', ':Rails!<CR>')
vim.keymap.set('n', '<leader>rr', ':Copen|Dispatch<CR>')

-- LSP
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, {})
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
-- vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, {})
vim.keymap.set("n", "<leader>cf", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local filetype = vim.bo[bufnr].filetype

  if filetype == "eruby" then
      local file_path = vim.api.nvim_buf_get_name(bufnr)
      local cmd = string.format("erblint --autocorrect %s", vim.fn.shellescape(file_path))

      vim.fn.system(cmd)
      -- Reload the buffer to see changes
      vim.cmd("e!")
  else
    vim.lsp.buf.format()
  end
end, { desc = "Format with Conform for eruby, LSP for others" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
