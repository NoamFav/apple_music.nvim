local music = require("apple_music.music_control")
local vim = vim

local function create_music_ui()
	local buf = vim.api.nvim_create_buf(false, true) -- Create scratch buffer
	local width = 50
	local height = 10
	local row = math.ceil((vim.o.lines - height) - 5)
	local col = math.ceil((vim.o.columns - width) + 5)

	-- Create a floating window
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	})

	local function update_ui()
		local handle = io.popen(
			'osascript -e \'tell application "Music" to get name of current track & " - " & artist of current track\''
		)
		local track = handle and handle:read("*a") or "No track playing"
		if handle then
			handle:close()
		end

		-- Get current volume
		local vol_handle = io.popen("osascript -e 'tell application \"Music\" to get sound volume'")
		local volume = vol_handle and vol_handle:read("*a") or "0"
		if vol_handle then
			vol_handle:close()
		end

		local slider = string.rep("█", math.floor(tonumber(volume) / 10))
			.. string.rep("░", 10 - math.floor(tonumber(volume) / 10))

		local lines = {
			"🎵 Current Track: " .. track:gsub("\n", ""),
			"",
			"   << Previous   ⏯️ Play/Pause   Next >>",
			"",
			"   🔉 Volume Down [" .. slider .. "] 🔊 Volume Up",
			"   🔇 Mute",
			"",
			"   Click or press 'q' to exit.",
		}
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	end

	-- Initial update
	update_ui()

	-- Update every 2 seconds
	vim.defer_fn(function()
		if vim.api.nvim_win_is_valid(win) then
			update_ui()
			vim.defer_fn(update_ui, 2000) -- Recursive update
		end
	end, 2000)

	-- Mouse and keybindings
	local opts = { noremap = true, silent = true, nowait = true }
	vim.api.nvim_buf_set_keymap(buf, "n", "h", ':lua require("apple_music.music_control").previous_track()<CR>', opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "l", ':lua require("apple_music.music_control").next_track()<CR>', opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "p", ':lua require("apple_music.music_control").play_pause()<CR>', opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "-", ':lua require("apple_music.music_control").volume_down()<CR>', opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "+", ':lua require("apple_music.music_control").volume_up()<CR>', opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "m", ':lua require("apple_music.music_control").volume_mute()<CR>', opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "q", ":close<CR>", opts)
	vim.api.nvim_buf_set_keymap(
		buf,
		"n",
		"<LeftMouse>",
		':lua require("apple_music.music_control").play_pause()<CR>',
		opts
	) -- Click to play/pause
end

return { create_music_ui = create_music_ui }
