vim.g.mapleader = " "

-- Disable netrw because we use nvim-tree.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("core.packer")

require("config.options")
require("config.filetypes")
require("plugins")
require("config.keymaps")
