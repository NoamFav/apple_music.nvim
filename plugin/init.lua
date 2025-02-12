local music_ui = require("apple_music.music_ui")

vim.api.nvim_create_user_command("MusicControl", function()
	music_ui.create_music_ui()
end, { desc = "Open Music Control UI" })

-- Leader key mapping to call MusicControl
vim.api.nvim_set_keymap("n", "<Leader>mc", ":MusicControl<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
	"n",
	"<Leader>mf",
	":lua require('apple_music.music_ui').focus_music_ui()<CR>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>mq",
	":lua require('apple_music.music_ui').close_music_ui()<CR>",
	{ noremap = true, silent = true }
)
