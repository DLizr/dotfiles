vim.keymap.set('n', "<Leader>fzf", require("fzf-lua").files,
                { desc = "Run fzf-lua" })

vim.opt.showmatch = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.path = "**"
vim.opt.lazyredraw = true
vim.opt.showcmd = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true

vim.opt.cino = "j1"

vim.keymap.set("i", "{<CR>", "{<CR>}<ESC>O",
                { desc = "Closing parentheses" })

vim.keymap.set("i", "{;<CR>", "{<CR>};<ESC>O",
                { desc = "Closing parentheses with semicolon" })

vim.keymap.set("n", "<Leader><CR>", "<CMD>!alacritty &<CR><CR>",
                { desc = "Run Alacritty in current folder" })

vim.keymap.set("n", "<C-c>", "<CMD>noh<CR><ESC>",
                { desc = "Nohighlight shortcut" })

vim.g.markdown_fenced_languages = {'vim', 'python', 'cpp', 'c', 'bash'}
vim.g.markdown_folding = 1

vim.opt.langmap = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"
