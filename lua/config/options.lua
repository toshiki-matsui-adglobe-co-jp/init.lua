-- スペースキーをリーダーキーとして設定
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Nerd Fontをインストールしてターミナルで選択している場合はtrueに設定
vim.g.have_nerd_font = true

-- 行番号をデフォルトで表示
vim.opt.number = true
vim.opt.relativenumber = true

-- マウスモードを有効化。スプリットのサイズ変更などに便利です
vim.opt.mouse = "a"

-- モードを表示しない（ステータスラインに既に表示されているため）
vim.opt.showmode = false

-- OSとNeovim間のクリップボードを同期
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- 改行時にインデントを維持
vim.opt.breakindent = true

-- アンドゥ履歴を保存
vim.opt.undofile = true

-- 大文字・小文字を無視した検索を有効化。ただし、検索語に大文字が含まれる場合は区別する
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- サインカラムを常に表示
vim.opt.signcolumn = "yes"

-- 更新時間を短縮
vim.opt.updatetime = 250

-- マッピングされたシーケンスの待ち時間を短縮
-- which-keyのポップアップが早く表示される
vim.opt.timeoutlen = 300

-- 新しいスプリットの開き方を設定
vim.opt.splitright = true
vim.opt.splitbelow = true

-- 特定の空白文字をエディタ内でどのように表示するかを設定
vim.opt.list = true
vim.opt.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "␣",
}

-- 置換をリアルタイムでプレビュー
vim.opt.inccommand = "split"

-- カーソルがある行をハイライト表示
vim.opt.cursorline = true

-- カーソル行のハイライト色を設定
vim.cmd([[
  highlight CursorLine ctermbg=darkgray guibg=#333333 cterm=reverse gui=reverse
]])

-- カーソルの上下に最低限確保する画面行数
vim.opt.scrolloff = 10
