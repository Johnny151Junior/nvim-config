local map = vim.keymap.set

-- Save / quit
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })

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
