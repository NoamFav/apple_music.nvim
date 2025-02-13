local telescope = require("telescope.builtin")

local M = {}

function M.get_playlists()
	local handle = io.popen("osascript -e 'tell application \"Music\" to get name of every playlist'")
	if handle == nil then
		print("🎵 No playlists found")
		return
	end
	local result = handle:read("*a")
	handle:close()
	local playlists = {}
	for playlist in result:gmatch("[^\r\n]+") do
		table.insert(playlists, playlist)
	end
	return playlists
end

function M.pick_playlist_shuffle()
	local playlists = M.get_playlists()
	telescope.pickers
		.new({}, {
			prompt_title = "Select Playlist to Shuffle",
			finder = telescope.finders.new_table({
				results = playlists,
			}),
			sorter = telescope.config.generic_sorter({}),
			attach_mappings = function(_, map)
				map("i", "<CR>", function(prompt_bufnr)
					local selection = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
					require("telescope.actions").close(prompt_bufnr)

					-- Shuffle and play the selected playlist
					local playlist_name = selection.value:gsub('"', '\\"') -- Escape double quotes
					os.execute(
						'osascript -e \'tell application "Music" to set shuffle mode of playlist "'
							.. playlist_name
							.. "\" to songs'"
					)
					os.execute('osascript -e \'tell application "Music" to play playlist "' .. playlist_name .. "\"'")
				end)
				return true
			end,
		})
		:find()
end

function M.pick_playlist()
	local playlists = M.get_playlists()
	telescope.pickers
		.new({}, {
			prompt_title = "Select Playlist",
			finder = telescope.finders.new_table({
				results = playlists,
			}),
			sorter = telescope.config.generic_sorter({}),
			attach_mappings = function(_, map)
				map("i", "<CR>", function(prompt_bufnr)
					local selection = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
					require("telescope.actions").close(prompt_bufnr)
					os.execute('osascript -e \'tell application "Music" to play playlist "' .. selection.value .. "\"'")
				end)
				return true
			end,
		})
		:find()
end

return M
