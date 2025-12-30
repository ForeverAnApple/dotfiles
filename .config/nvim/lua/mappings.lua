require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- :q -> :qa, :q! -> :qa!, :wq -> :wqa
vim.cmd("cnoreabbrev <expr> q getcmdtype() == ':' && getcmdline() == 'q' ? 'qa' : 'q'")
vim.cmd("cnoreabbrev <expr> q! getcmdtype() == ':' && getcmdline() == 'q!' ? 'qa!' : 'q!'")
vim.cmd("cnoreabbrev <expr> wq getcmdtype() == ':' && getcmdline() == 'wq' ? 'wqa' : 'wq'")

-- Window splits
map("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Split window vertically" })
map("n", "<leader>sh", "<cmd>split<CR>", { desc = "Split window horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
