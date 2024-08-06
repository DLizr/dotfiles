return {
    {
        "mrcjkb/rustaceanvim",
        version = '^5',
        lazy = false,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- Treesitter > LSP
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    client.server_capabilities.semanticTokensProvider = nil
                end
            })

            -- Diagnostics are distracting, but, just in case, I'll leave it as a option.
            -- (By default diagnostics are enabled, hence setting true)
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
            toggle_diagnostic()

            vim.keymap.set("n", "<Leader>td", toggle_diagnostic,
                { desc = "Toggle Diagnostics (LSP)" })

            vim.keymap.set("n", "<Leader>lr", vim.lsp.buf.references,
                { desc = "List References (LSP)" })
        end,
    }
}
