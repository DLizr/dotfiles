vim.keymap.set("n", "<F5>", "<CMD>!Compile %<CR>",
                { desc = "Minimalist compilation" })
vim.api.nvim_create_user_command("CP", ":r ~/.vim/snippets/competitive.cpp", {})
