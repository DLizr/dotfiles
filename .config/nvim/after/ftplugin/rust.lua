vim.keymap.set("n", "<Leader>rd", function() vim.cmd.RustLsp("renderDiagnostic") end,
                { desc = "Render Diagnostic (LSP)" })
