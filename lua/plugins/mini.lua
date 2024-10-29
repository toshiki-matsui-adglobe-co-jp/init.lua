return {
    -- 様々な小さなプラグインのコレクション
    'echasnovski/mini.nvim',
    enabled = not vim.g.vscode,
    config = function()
        -- テキストオブジェクトを改良
        require('mini.ai').setup {
            n_lines = 500
        }

        -- サラウンドの追加/削除/置換
        require('mini.surround').setup()

        -- シンプルなステータスライン
        local statusline = require 'mini.statusline'
        statusline.setup {
            use_icons = vim.g.have_nerd_font
        }

        -- カーソル位置の表示形式を設定
        statusline.section_location = function()
            return '%2l:%-2v'
        end
    end
}
