local M = {}

function M.current_track()
	local handle = io.popen(
		'osascript -e \'tell application "Music" to get name of current track & " - " & artist of current track\''
	)
	if handle == nil then
		print("🎵 No track playing")
		return
	end
	local result = handle:read("*a")
	handle:close()
	print("🎵 " .. result)
end

-- Play/Pause
function M.play_pause()
	os.execute("osascript -e 'tell application \"Music\" to playpause'")
	print("⏯️ Play/Pause toggled")
end

-- Next Track
function M.next_track()
	os.execute("osascript -e 'tell application \"Music\" to next track'")
	print("⏭️ Next track")
end

-- Previous Track
function M.previous_track()
	os.execute("osascript -e 'tell application \"Music\" to previous track'")
	print("⏮️ Previous track")
end

function M.volume_up()
	os.execute("osascript -e 'tell application \"Music\" to set sound volume to (sound volume + 10)'")
	print("🔊 Volume up")
end

function M.volume_down()
	os.execute("osascript -e 'tell application \"Music\" to set sound volume to (sound volume - 10)'")
	print("🔉 Volume down")
end

function M.volume_mute()
	os.execute("osascript -e 'tell application \"Music\" to set sound volume to 0'")
	print("🔇 Volume muted")
end

return M
