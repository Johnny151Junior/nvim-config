local ensure_packer = function()
  local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    })

    vim.cmd("packadd packer.nvim")
    return true
  end

  return false
end

local packer_bootstrap = ensure_packer()

require("packer").startup(function(use)
  use "wbthomason/packer.nvim"

  -- Dependencies
  use "nvim-lua/plenary.nvim"
  use "nvim-tree/nvim-web-devicons"

  -- Search files/text
  use {
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  }

  -- Folder tree
  use {
    "nvim-tree/nvim-tree.lua",
    requires = { "nvim-tree/nvim-web-devicons" },
  }

  -- Git
  use "lewis6991/gitsigns.nvim"

  use {
    "sindrets/diffview.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  }

  -- LSP
  use "neovim/nvim-lspconfig"

  -- Autocomplete
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"

  -- Formatter
  use "stevearc/conform.nvim"

  if packer_bootstrap then
    require("packer").sync()
  end
end)
