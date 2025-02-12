local vim = vim

local buf = nil
local win = nil

local function create_music_ui()
	if win and vim.api.nvim_win_is_valid(win) then
		print("Music UI is already open!")
		return
	end

	buf = vim.api.nvim_create_buf(false, true)
	local width = 60
	local height = 10
	local row = 1
	local col = vim.o.columns - width - 2

	win = vim.api.nvim_open_win(buf, false, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
		focusable = false,
	})

	local function centered_text(text)
		local padding = math.floor((width - #text) / 2)
		if padding > 0 then
			return string.rep(" ", padding) .. text
		else
			return text
		end
	end

	local function create_volume_slider(volume)
		local filled = math.floor(volume / 10)
		local empty = 10 - filled
		return string.rep("█", filled) .. string.rep("░", empty)
	end

	local function get_volume_icon(volume)
		if volume == 0 then
			return "󰖁" -- Mute icon
		elseif volume <= 30 then
			return "奄" -- Low volume
		elseif volume <= 70 then
			return "奔" -- Medium volume
		else
			return "墳" -- High volume
		end
	end

	local function create_ui(track, volume)
		local volume_icon = get_volume_icon(tonumber(volume))
		local slider = " " .. volume_icon .. " [" .. create_volume_slider(tonumber(volume)) .. "] " .. "墳"

		local lines = {
			centered_text("   Current Track:"),
			centered_text(track:gsub("\n", "") or "No track playing"),
			" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
			centered_text("   Controls:"),
			centered_text("  h: Previous     p: Play/Pause     l: Next"),
			" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
			centered_text(" 墳  Volume:"),
			centered_text(slider),
			centered_text("-: Volume Down   +: Volume Up   󰖁 : Mute"),
			" ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
			centered_text("   Press 'q' to close."),
		}

		return lines
	end

	local function update_ui()
		if not vim.api.nvim_win_is_valid(win) then
			return
		end

		local handle = io.popen(
			'osascript -e \'tell application "Music" to get name of current track & " - " & artist of current track\''
		)
		local track = handle and handle:read("*a") or "No track playing"
		if handle then
			handle:close()
		end

		local vol_handle = io.popen("osascript -e 'tell application \"Music\" to get sound volume'")
		local volume = vol_handle and vol_handle:read("*a") or "0"
		if vol_handle then
			vol_handle:close()
		end

		local lines = create_ui(track, volume)
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	end

	-- Initial update and recursive updates every 2 seconds
	local function recursive_update()
		if vim.api.nvim_win_is_valid(win) then
			update_ui()
			vim.defer_fn(recursive_update, 2000)
		end
	end

	update_ui()
	recursive_update()

	-- Keybindings for interaction
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(buf, "n", "h", ':lua require("apple_music.music_control").previous_track()<CR>', opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "l", ':lua require("apple_music.music_control").next_track()<CR>', opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "p", ':lua require("apple_music.music_control").play_pause()<CR>', opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "-", ':lua require("apple_music.music_control").volume_down()<CR>', opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "+", ':lua require("apple_music.music_control").volume_up()<CR>', opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "m", ':lua require("apple_music.music_control").volume_mute()<CR>', opts)
	vim.api.nvim_buf_set_keymap(buf, "n", "q", ":lua require('apple_music_ui').close_music_ui()<CR>", opts)
end

local function close_music_ui()
	if win and vim.api.nvim_win_is_valid(win) then
		vim.api.nvim_win_close(win, true)
		win = nil
		buf = nil
	end
end

return {
	create_music_ui = create_music_ui,
	close_music_ui = close_music_ui,
}
