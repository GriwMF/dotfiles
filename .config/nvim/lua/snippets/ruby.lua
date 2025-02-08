-- First, let's define the snippets
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("ruby", {
  s("minitest", {
    t("require 'test_helper'"),
    t({ "", "class " }),
    i(1, "ClassName"),
    t({ " < ActiveSupport::TestCase", "  " }),
    i(0),
    t({ "", "end" })
  }),

  s("template_test", {
    t("require 'rails_helper'"),
    t({ "", "RSpec.describe " }),
    i(1, "Class"),
    t(", type: :"),
    i(2, "model"),
    t({ " do", "  " }),
    i(0),
    t({ "", "end" })
  })
})


-- Helper function to expand snippet
local function expand_test_snippet(is_spec)
  if is_spec then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('itemplate_test', true, false, true), 'n', true)
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('iminitest', true, false, true), 'n', true)
  end
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, false, true), '', true)
end

-- Define the OpenTestAlternate function
local function open_test_alternate()
  local test_path = vim.fn.eval('rails#buffer().alternate()')
  vim.cmd('e ' .. test_path)
  
  local is_empty = vim.fn.filereadable(test_path) == 0 and 
                   vim.fn.join(vim.fn.getline(1, '$'), "\n") == ''
  
  if is_empty then
    local is_spec = string.match(test_path, "spec/") ~= nil
    expand_test_snippet(is_spec)
  end
end

-- Create the command
vim.api.nvim_create_user_command('AC', open_test_alternate, {})
