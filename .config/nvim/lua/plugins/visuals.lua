return {
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme onedark]])
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false,
        config = function()
            require("nvim-treesitter.configs").setup {
                ensure_installed = { "cpp", "python", "lua", "bash", "rust", "latex", "haskell" },
                highlight = {enable = true}
            }
        end,
    }
}
