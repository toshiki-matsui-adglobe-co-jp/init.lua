return {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {'nvim-lua/plenary.nvim',
                    { -- エラーが発生する場合は telescope-fzf-native のREADMEを参照してインストールしてください
        'nvim-telescope/telescope-fzf-native.nvim',
        -- 'build' はプラグインがインストール/更新されたときにコマンドを実行します
        -- これは起動時に毎回実行されるわけではありません
        build = 'make',
        -- 'cond' はこのプラグインをインストールおよびロードするかどうかを決定する条件です
        cond = function()
            return vim.fn.executable 'make' == 1
        end
    }, {'nvim-telescope/telescope-ui-select.nvim'},
    -- きれいなアイコンを取得するのに便利ですが、Nerd Fontが必要です
                    {
        'nvim-tree/nvim-web-devicons',
        enabled = vim.g.have_nerd_font
    }},
    config = function()
        -- Telescopeの設定
        -- 詳細は `:help telescope` および `:help telescope.setup()` を参照してください
        require('telescope').setup {
            -- デフォルトのマッピングや設定をここに記述できます
            -- 詳細は `:help telescope.setup()` を参照してください
            extensions = {
                ['ui-select'] = {require('telescope.themes').get_dropdown()}
            }
        }

        -- Telescopeの拡張機能を有効化（インストールされている場合）
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')

        -- Telescopeの組み込み関数を参照
        -- 詳細は `:help telescope.builtin` を参照してください
        local builtin = require 'telescope.builtin'
        vim.keymap.set('n', '<leader>sh', builtin.help_tags, {
            desc = '[S]earch [H]elp'
        })
        vim.keymap.set('n', '<leader>sk', builtin.keymaps, {
            desc = '[S]earch [K]eymaps'
        })
        vim.keymap.set('n', '<leader>sf', builtin.find_files, {
            desc = '[S]earch [F]iles'
        })
        vim.keymap.set('n', '<leader>ss', builtin.builtin, {
            desc = '[S]earch [S]elect Telescope'
        })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, {
            desc = '[S]earch current [W]ord'
        })
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, {
            desc = '[S]earch by [G]rep'
        })
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, {
            desc = '[S]earch [D]iagnostics'
        })
        vim.keymap.set('n', '<leader>sr', builtin.resume, {
            desc = '[S]earch [R]esume'
        })
        vim.keymap.set('n', '<leader>s.', builtin.oldfiles, {
            desc = '[S]earch Recent Files'
        })
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, {
            desc = '既存のバッファを探す'
        })

        -- デフォルトの動作とテーマを上書きする少し高度な例
        vim.keymap.set('n', '<leader>/', function()
            -- Telescopeに追加の設定を渡して、テーマやレイアウトを変更できます
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false
            })
        end, {
            desc = '現在のバッファ内をファジー検索'
        })

        -- 追加の設定オプションを渡すことも可能です
        -- 詳細は `:help telescope.builtin.live_grep()` を参照してください
        vim.keymap.set('n', '<leader>s/', function()
            builtin.live_grep {
                grep_open_files = true,
                prompt_title = '開いているファイル内をライブグレップ'
            }
        end, {
            desc = '[S]earch [/] in Open Files'
        })

        -- Neovimの設定ファイルを検索するショートカット
        vim.keymap.set('n', '<leader>sn', function()
            builtin.find_files {
                cwd = vim.fn.stdpath 'config'
            }
        end, {
            desc = '[S]earch [N]eovim files'
        })
    end
}
