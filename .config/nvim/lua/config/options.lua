local options = {
  editor = {
    expandtab = true,
    tabstop = 2,
    softtabstop = 2,
    shiftwidth = 2,
    smartindent = true,
    swapfile = false,
  },
  ui = {
    number = true,
    scrolloff = 5,
    cursorline = true,
    termguicolors = true,
    showmode = false,
  },
  search = {
    ignorecase = true,
    smartcase = true,
  }
}

for _, opts in pairs(options) do
  for key, value in pairs(opts) do
    vim.opt[key] = value
  end
end
