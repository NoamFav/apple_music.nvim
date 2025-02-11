local music_ui = require("apple_music.nvim.music_ui")

vim.api.nvim_create_user_command("MusicControl", function()
	music_ui.create_music_ui()
end, { desc = "Open Music Control UI" })
