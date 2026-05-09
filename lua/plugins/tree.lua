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
