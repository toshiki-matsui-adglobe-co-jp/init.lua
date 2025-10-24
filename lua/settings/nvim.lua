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

-- ノーマルモードで <Esc> を押したときに検索のハイライトをクリア
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- 診断情報のキーマップ
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, {
  desc = "診断情報のリストを開く",
})

-- 内蔵ターミナルで <Esc><Esc> でターミナルモードを終了
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", {
  desc = "ターミナルモードを終了",
})

-- CTRL + hjkl でウィンドウ間を移動 VSCodeでは動作しない
if not vim.g.vscode then
  vim.keymap.set("n", "<C-h>", "<C-w><C-h>", {
    desc = "左のウィンドウに移動",
  })
  vim.keymap.set("n", "<C-l>", "<C-w><C-l>", {
    desc = "右のウィンドウに移動",
  })
  vim.keymap.set("n", "<C-j>", "<C-w><C-j>", {
    desc = "下のウィンドウに移動",
  })
  vim.keymap.set("n", "<C-k>", "<C-w><C-k>", {
    desc = "上のウィンドウに移動",
  })
end

-- vscode拡張機能が有効な場合は、VSCodeのundo/redoを利用
if vim.g.vscode then
  vim.keymap.set("n", "u", "<Cmd>call VSCodeNotify('undo')<CR>")
  vim.keymap.set("n", "<C-r>", "<Cmd>call VSCodeNotify('redo')<CR>")
end

-- テキストをヤンク（コピー）したときにハイライト表示
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "テキストをヤンクしたときにハイライト表示",
  group = vim.api.nvim_create_augroup("highlight_yank", {
    clear = true,
  }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
