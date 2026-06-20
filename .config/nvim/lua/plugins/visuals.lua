return {
    {
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            -- vim.cmd([[colorscheme onedark]])
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
    },
    {
        "rrethy/base16-nvim",
        lazy = false,
        config = function()
            require("base16-colorscheme").setup({
                base00 = "#17181C",
                base01 = "#1E1F24",
                base02 = "#26272B",
                base03 = "#47484F",
                base04 = "#8F9093",
                base05 = "#B0B1B4",
                base06 = "#CBCCCE",
                base07 = "#E4E5E7",
                base08 = "#FA3867",
                base09 = "#F3872F",
                base0A = "#FEBD16",
                base0B = "#3FD43B",
                base0C = "#47E7CE",
                base0D = "#53ADE1",
                base0E = "#AD60FF",
                base0F = "#FC3F2C",
            })
        end
    }
}
