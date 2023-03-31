source ~/.vim/vimrc

call plug#begin()
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-neorg/neorg' | Plug 'nvim-lua/plenary.nvim'
Plug 'navarasu/onedark.nvim'
call plug#end()

lua << EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "norg", "cpp", "python", "lua", "bash", "rust" },
    highlight = {enable = true}
}
require('neorg').setup {
    load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.norg.dirman"] = { -- Manages Neorg workspaces
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
