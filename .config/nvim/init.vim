call plug#begin()
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-neorg/neorg' | Plug 'nvim-lua/plenary.nvim'
Plug 'navarasu/onedark.nvim'
Plug 'SirVer/ultisnips'

" Autocompletion garbage
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'mrcjkb/rustaceanvim'
call plug#end()

lua << EOF
    --
    -- Treesitter
    --
    require'nvim-treesitter.configs'.setup {
        ensure_installed = { "norg", "cpp", "python", "lua", "bash", "rust", "latex" },
        highlight = {enable = true}
    }

    --
    -- Neorg
    --
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

    -- 
    -- nvim-cmp
    --
    vim.g.nvim_cmp_enabled = false
    local cmp = require("cmp")
    cmp.setup({
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            end,
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
            ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),
            ['<C-f>'] = cmp.mapping.scroll_docs(-4),
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'ultisnips' }, -- For ultisnips users.
            }, {
            { name = 'buffer' },
        }),
        enabled = function()
            return vim.g.nvim_cmp_enabled
        end,
    })

    --
    -- LSP setup
    --
    local lspconfig = require("lspconfig")
    lspconfig.clangd.setup {}
    lspconfig.rust_analyzer.setup {
        settings = {
            ['rust-analyzer'] = {}
        }
    }
    lspconfig.jedi_language_server.setup {}
    vim.g.nvim_cmp_enabled = false

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            client.server_capabilities.semanticTokensProvider = nil
        end
    })
EOF


colorscheme onedark

source ~/.vim/vimrc
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath

function NvimCmpToggle()
    if g:nvim_cmp_enabled
        let g:nvim_cmp_enabled = v:false
    else
        let g:nvim_cmp_enabled = v:true
    endif
endfunction

noremap <Leader>ac :call NvimCmpToggle()<CR>

lua << EOF
    vim.g.diagnostic_enabled = true
    local toggle_diagnostic = function()
        if vim.g.diagnostic_enabled then
            vim.g.diagnostic_enabled = false
            vim.diagnostic.disable()
        else
            vim.g.diagnostic_enabled = true
            vim.diagnostic.enable()
        end
    end
    vim.keymap.set("n", "<Leader>td", toggle_diagnostic)
EOF
