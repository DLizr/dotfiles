source ~/.vim/vimrc

call plug#begin()
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-neorg/neorg' | Plug 'nvim-lua/plenary.nvim'
Plug 'navarasu/onedark.nvim'
call plug#end()

lua << EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "norg", "cpp", "python", "lua", "bash", "rust", "latex" },
    highlight = {enable = true}
}
require('neorg').setup {
    load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
                workspaces = {
                    notes = "~/notes",
                },
            },
        },
    },
}
EOF
colorscheme onedark
