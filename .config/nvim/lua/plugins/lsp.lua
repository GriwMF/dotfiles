return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()

      local registry = require("mason-registry")
      local packages = { }

      for _, package_name in ipairs(packages) do
        local package = registry.get_package(package_name)
        if not package:is_installed() then
          package:install()
        end
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
      ensure_installed = {
        "ruby_lsp",
        "eslint",
        "lua_ls",
        "ts_ls",
        "rust_analyzer",
        "gopls",
        "html",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      vim.diagnostic.config({
        virtual_text = true,
      })

      -- Enable inlay hints for all files with LSP support
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          local bufnr = args.buf
          -- Check if the LSP supports inlay hints
          if client and client.server_capabilities.inlayHintProvider then
            vim.defer_fn(function()
              vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end, 3000)
          end
        end,
      })

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require("lspconfig")
      lspconfig.ruby_lsp.setup({
        capabilities = capabilities
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
      lspconfig.html.setup({
        capabilities = capabilities,
        filetypes = { "html", "eruby" }
      })
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.eslint.setup({
        capabilities = capabilities,
      })
      lspconfig.gopls.setup({
        capabilities = capabilities,
      })
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = {
              command = "clippy",
            },
            inlayHints = {
              bindingModeHints = {
                enable = true,
              },
              chainingHints = {
                enable = true,
              },
              closingBraceHints = {
                enable = true,
                minLines = 25,
              },
              closureReturnTypeHints = {
                enable = "always", -- "always", "never", or "with_block"
              },
              expressionAdjustmentHints = {
                enable = "always", -- "always", "never", or "reborrow"
              },
              lifetimeElisionHints = {
                enable = "always", -- "always", "never", or "skip_trivial"
                useParameterNames = true,
              },
              parameterHints = {
                enable = true,
              },
              reborrowHints = {
                enable = "always", -- "always", "never", or "mutable"
              },
              typeHints = {
                enable = true,
                hideClosureInitialization = false,
                hideNamedConstructor = false,
              },
            },
          }
        },
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft = {
        eruby = { "erb_lint" }
      }
      -- Run linter when reading a buffer, writing a buffer, and changing in insert mode
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  }
}
