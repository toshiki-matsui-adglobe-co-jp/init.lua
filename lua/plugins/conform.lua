return {
    'stevearc/conform.nvim',
    enabled = not vim.g.vscode,
    event = {'BufWritePre'},
    cmd = {'ConformInfo'},
    keys = {{
        '<leader>f',
        function()
            require('conform').format {
                async = true,
                lsp_format = 'fallback'
            }
        end,
        mode = '',
        desc = '[F]ormat buffer'
    }},
    opts = {
        notify_on_error = false,
        format_on_save = function(bufnr)
            local disable_filetypes = {
                c = true,
                cpp = true
            }
            local lsp_format_opt
            if disable_filetypes[vim.bo[bufnr].filetype] then
                lsp_format_opt = 'never'
            else
                lsp_format_opt = 'fallback'
            end
            return {
                timeout_ms = 500,
                lsp_format = lsp_format_opt
            }
        end,
        formatters_by_ft = {
            lua = {'stylua'}
            -- 複数のフォーマッタを順番に実行することも可能
            -- python = { "isort", "black" },
            --
            -- 最初に利用可能なフォーマッタを使用する場合
            -- javascript = { "prettierd", "prettier", stop_after_first = true },
        }
    }
}
