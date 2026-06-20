return {
    "ibhagwan/fzf-lua",
    {
        "SirVer/ultisnips",
        init = function()
            vim.g.UltiSnipsExpandTrigger = '<tab>'
            vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
            vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>'
            vim.g.UltiSnipsSnippetDirectories={"ulti-snippets"}
        end
    },
    {
        "vimwiki/vimwiki",
        init = function()
            vim.g.vimwiki_list = {{path = '~/Data/vimwiki'}}
        end,
    },

    -- Some weird dependency, I guess I'm not touching it
    "nvim-tree/nvim-web-devicons",

    {
        "subnut/nvim-ghost.nvim",
        init = function()
            vim.g.nvim_ghost_autostart = 0
        end,
    },
}
