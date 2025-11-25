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
