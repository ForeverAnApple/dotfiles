require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "<leader>fm", function()
  require("conform").format()
end, { desc = "File Format with conform" })

map("i", "jk", "<ESC>", { desc = "Escape insert mode" })

-- mapping with a lua function
-- Floating terminal
map("n", "<leader>ft", function()
  require("nvchad.term").toggle({
		pos = "float",
		id ="floatTerm",
		float_opts = {
			border = "double"
	  }})
end, { desc = "Terminal toggle floating" })

map("n", "<leader>lg", function()
  require("nvchad.term").toggle({
		pos = "float",
		id ="lgFloatTerm",
		float_opts = {
			border = "double",
			width = 0.7,
			height = 0.6,
			row = 0.15,
			col = 0.15,
	  },
		cmd = "lazygit"
	})
end, { desc = "Lazygit floating terminal" })
