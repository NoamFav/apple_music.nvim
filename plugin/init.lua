local music_ui = require("apple_music.music_ui")
local music_control = require("apple_music.music_control")
local playlist_picker = require("apple_music.playlist_picker")
local vim = vim

vim.api.nvim_create_user_command("MusicControl", function()
	music_ui.create_music_ui()
end, { desc = "Open Music Control UI" })

vim.api.nvim_create_user_command("MusicPickPlaylist", function()
	local shuffle = vim.fn.input("Shuffle? (y/n): ")
	if shuffle:lower() == "y" then
		playlist_picker.pick_playlist_shuffle()
	else
		playlist_picker.pick_playlist()
	end
end, { desc = "Pick a playlist" })

vim.keymap.set(
	"n",
	"<Leader>mu",
	":MusicControl<CR>",
	{ noremap = true, silent = true, desc = "Open Music Control UI" }
)

vim.keymap.set("n", "<Leader>mp", function()
	music_control.play_pause()
end, { noremap = true, silent = true, desc = "Play/Pause Music" })

vim.keymap.set("n", "<Leader>mn", function()
	music_control.next_track()
end, { noremap = true, silent = true, desc = "Next Track" })

vim.keymap.set("n", "<Leader>mb", function()
	music_control.previous_track()
end, { noremap = true, silent = true, desc = "Previous Track" })

vim.keymap.set("n", "<Leader>m+", function()
	music_control.volume_up()
end, { noremap = true, silent = true, desc = "Increase Volume" })

vim.keymap.set("n", "<Leader>m-", function()
	music_control.volume_down()
end, { noremap = true, silent = true, desc = "Decrease Volume" })

vim.keymap.set("n", "<Leader>mq", function()
	music_ui.close_music_ui()
end, { noremap = true, silent = true, desc = "Close Music Control UI" })

vim.keymap.set("n", "<Leader>mm", function()
	music_ui.focus_music_ui()
end, { noremap = true, silent = true, desc = "Focus Music UI" })

vim.keymap.set("n", "<Leader>pp", function()
	vim.cmd("MusicPickPlaylist")
end, { noremap = true, silent = true, desc = "Pick a music playlist" })
