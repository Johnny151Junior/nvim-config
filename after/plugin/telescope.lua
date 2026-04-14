local buildin = require('telescope.builtin')
vim.keymap.set("n",'<leader>pf',buildin.find_files,{})
vim.keymap.set("n",'<C-p>',buildin.git_files,{})
vim.keymap.set("n",'<leader>ps', function()
	buildin.grep_string({ search = vim.fn.input("Grep > ") });
end)
