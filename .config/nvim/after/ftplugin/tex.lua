vim.keymap.set("n", "<F5>", "<CMD>!pdflatex %<CR>", { desc = "Compile .tex" })

vim.g.UltiSnipsExpandTrigger = '<tab>'
vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>'
vim.g.UltiSnipsSnippetDirectories = {"~/.vim/ulti-snippets"}

local open_inkscape = function()
    local name = vim.fn.matchstr(vim.fn.getline('.'), '{\\zs.\\{-}\\ze}')
    vim.fn.execute("!inkscape_open ./figures/" .. name)
end

vim.keymap.set("n", "<Leader>io", open_inkscape, { desc = "Open Inscape" })
