return {
    "ibhagwan/fzf-lua",
    "SirVer/ultisnips",
    {
        "vimwiki/vimwiki",
        init = function()
            vim.g.vimwiki_list = {{path = '~/Data/vimwiki'}}
        end,
    },

    -- Some weird dependency, I guess I'm not touching it
    "nvim-tree/nvim-web-devicons",

    -- This is the way
    {
        "m4xshen/hardtime.nvim",
        dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
        opts = {}
    }
}
