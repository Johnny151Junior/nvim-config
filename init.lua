vim.g.mapleader = " "

-- Filetypes used by the current workflow.
vim.filetype.add({
  filename = {
    ["go.work"] = "gowork",
  },
  extension = {
    gotmpl = "gotmpl",
  },
  pattern = {
    [".*%.go%.tmpl"] = "gotmpl",
  },
})

-- Core editor options.
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"

-- Disable netrw because nvim-tree replaces it.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Bootstrap lazy.nvim if it is missing.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      pcall(function()
        require("nvim-tree").setup({
          view = {
            width = 32,
          },
          renderer = {
            group_empty = true,
          },
        })
      end)
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      pcall(function()
        require("gitsigns").setup()
      end)
    end,
  },

  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  { "neovim/nvim-lspconfig" },

  {
    "williamboman/mason.nvim",
    config = function()
      pcall(function()
        require("mason").setup()
      end)
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      pcall(function()
        require("mason-lspconfig").setup({
          ensure_installed = {
            "gopls",
            "ts_ls",
            "clangd",
          },
          automatic_installation = true,
        })
      end)
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      pcall(function()
        require("mason-tool-installer").setup({
          ensure_installed = {
            "goimports",
            "gofumpt",
            "prettier",
            "clang-format",
          },
          auto_update = false,
          run_on_start = true,
        })
      end)
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      pcall(function()
        local cmp = require("cmp")
        cmp.setup({
          mapping = cmp.mapping.preset.insert({
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<Tab>"] = cmp.mapping.select_next_item(),
            ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          }),
          sources = {
            { name = "nvim_lsp" },
            { name = "buffer" },
            { name = "path" },
          },
        })
      end)
    end,
  },

  {
    "stevearc/conform.nvim",
    config = function()
      pcall(function()
        require("conform").setup({
          formatters_by_ft = {
            go = { "goimports", "gofumpt" },

            javascript = { "prettier" },
            javascriptreact = { "prettier" },
            typescript = { "prettier" },
            typescriptreact = { "prettier" },

            c = { "clang_format" },
            cpp = { "clang_format" },

            json = { "prettier" },
            html = { "prettier" },
            css = { "prettier" },
            markdown = { "prettier" },
          },
        })
      end)
    end,
  },
}

require("lazy").setup(plugins, {
  defaults = {
    lazy = false,
  },
  checker = {
    enabled = true,
    notify = false,
  },
})

pcall(function()
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  vim.lsp.config("gopls", {
    capabilities = capabilities,
    settings = {
      gopls = {
        gofumpt = true,
        staticcheck = true,
      },
    },
  })

  vim.lsp.config("ts_ls", {
    capabilities = capabilities,
  })

  vim.lsp.config("clangd", {
    capabilities = capabilities,
  })

  vim.lsp.enable({
    "gopls",
    "ts_ls",
    "clangd",
  })
end)

local map = vim.keymap.set

-- Save / quit
map("n", "<leader>s", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })

-- Window commands
map("n", "<leader>w", "<C-w>", { desc = "Window commands" })

-- File tree
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree" })
map("n", "<leader>o", "<cmd>NvimTreeFocus<cr>", { desc = "Focus file tree" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Search text" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })

-- LSP
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "Find references" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover docs" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show error" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous error" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next error" })

-- Format
map({ "n", "v" }, "<leader>f", function()
  require("conform").format({
    async = true,
    lsp_format = "fallback",
  })
end, { desc = "Format file" })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true }),
  callback = function(args)
    require("conform").format({
      bufnr = args.buf,
      async = false,
      lsp_format = "fallback",
    })
  end,
})

-- Git signs
map("n", "]c", function()
  require("gitsigns").nav_hunk("next")
end, { desc = "Next git change" })

map("n", "[c", function()
  require("gitsigns").nav_hunk("prev")
end, { desc = "Previous git change" })

map("n", "<leader>gp", function()
  require("gitsigns").preview_hunk()
end, { desc = "Preview git change" })

map("n", "<leader>gb", function()
  require("gitsigns").blame_line({ full = true })
end, { desc = "Git blame line" })

map("n", "<leader>gs", function()
  require("gitsigns").stage_hunk()
end, { desc = "Stage git hunk" })
