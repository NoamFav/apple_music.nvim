local music_ui = require("apple_music.music_ui")

vim.api.nvim_create_user_command("MusicControl", function()
	music_ui.create_music_ui()
end, { desc = "Open Music Control UI" })

-- Leader key mapping to call MusicControl
-- Open Music Control UI
vim.api.nvim_set_keymap("n", "<Leader>mu", ":MusicControl<CR>", { noremap = true, silent = true })

-- Play/Pause
vim.api.nvim_set_keymap(
	"n",
	"<Leader>mp",
	":lua require('apple_music.music_control').play_pause()<CR>",
	{ noremap = true, silent = true }
)

-- Next Track
vim.api.nvim_set_keymap(
	"n",
	"<Leader>mn",
	":lua require('apple_music.music_control').next_track()<CR>",
	{ noremap = true, silent = true }
)

-- Previous Track
vim.api.nvim_set_keymap(
	"n",
	"<Leader>mb",
	":lua require('apple_music.music_control').previous_track()<CR>",
	{ noremap = true, silent = true }
)

-- Volume Up
vim.api.nvim_set_keymap(
	"n",
	"<Leader>m+",
	":lua require('apple_music.music_control').volume_up()<CR>",
	{ noremap = true, silent = true }
)

-- Volume Down
vim.api.nvim_set_keymap(
	"n",
	"<Leader>m-",
	":lua require('apple_music.music_control').volume_down()<CR>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>mq",
	":lua require('apple_music.music_ui').close_music_ui()<CR>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>mf",
	":lua require('apple_music.music_ui').focus_music_ui()<CR>",
	{ noremap = true, silent = true }
)
