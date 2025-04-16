<div align="center">

# 🎵 Apple Music Neovim Plugin

[![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)](https://neovim.io/)
[![Lua](https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)](https://www.lua.org/)
[![Apple Music](https://img.shields.io/badge/Apple_Music-FA243C?style=for-the-badge&logo=apple-music&logoColor=white)](https://www.apple.com/apple-music/)

Control Apple Music directly from Neovim with a beautiful floating UI

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![macOS](https://img.shields.io/badge/platform-macOS-lightgrey)

</div>

---

## ✨ Overview

This plugin allows you to control **Apple Music** without leaving your Neovim environment. It provides an elegant floating UI that displays the current track information and enables playback control through simple key mappings.

<div align="center">
  <img src="https://github.com/NoamFav/apple_music.nvim/raw/main/screenshots/music_ui.png" width="600" alt="Apple Music Neovim UI">
</div>

## 🚀 Features

<table>
<tr>
<td width="50%" valign="top">

### Music Control
- 🎮 Play/Pause current track
- ⏭️ Skip to next track
- ⏮️ Go to previous track
- 🔊 Adjust volume up/down
- 📑 Browse and select playlists

</td>
<td width="50%" valign="top">

### UI Elements
- 🪟 Elegant floating window UI
- 🔄 Auto-updating track information (every 2s)
- 📊 Visual volume indicator
- ⏱️ Track progress display
- 🎨 Stylish minimal design

</td>
</tr>
</table>

## 📋 Requirements

- **Neovim 0.7+**
- **macOS** (uses `osascript` to control Apple Music)
- **Telescope.nvim** (for playlist picker functionality)
- **Plenary.nvim** (dependency for Telescope)

## 📦 Installation

<details open>
<summary><b>Using Lazy.nvim</b> (recommended)</summary>
<br>

Add the following to your Neovim configuration:

```lua
{
  "NoamFav/apple_music.nvim",
  dependencies = { 
    "nvim-telescope/telescope.nvim", 
    "nvim-lua/plenary.nvim" 
  },
  config = function()
    require("apple_music").setup({
      -- Optional configuration here
    })
  end,
}
```
</details>

<details>
<summary><b>Using Packer.nvim</b></summary>
<br>

```lua
use {
  "NoamFav/apple_music.nvim",
  requires = { 
    "nvim-telescope/telescope.nvim", 
    "nvim-lua/plenary.nvim" 
  },
  config = function()
    require("apple_music").setup()
  end
}
```
</details>

<details>
<summary><b>Using Vim-Plug</b></summary>
<br>

```vim
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'NoamFav/apple_music.nvim'

" In your init.vim/init.lua after plug#end():
" lua require('apple_music').setup()
```
</details>

## 🎯 Usage

### Commands

| Command | Description |
|---------|-------------|
| `:MusicControl` | Opens the floating music control UI |
| `:FocusMusicUI` | Focuses on the floating window (or returns focus to previous window) |
| `:MusicPickPlaylist` | Opens Telescope picker to select a playlist |

### Default Key Mappings

| Mapping | Action |
|---------|--------|
| `<Leader>mu` | Open Music Control UI |
| `<Leader>mp` | Play/Pause Music |
| `<Leader>mn` | Next Track |
| `<Leader>mb` | Previous Track |
| `<Leader>m+` | Increase Volume |
| `<Leader>m-` | Decrease Volume |
| `<Leader>mq` | Close Music Control UI |
| `<Leader>mm` | Focus Music UI |
| `<Leader>pp` | Pick Playlist (with optional shuffle) |

## 📁 Plugin Structure

The plugin is organized into several modules:

- **`init.lua`**: Entry point with setup function and command registration
- **`music_control.lua`**: Functions for controlling Apple Music via osascript
- **`music_ui.lua`**: Floating UI implementation with Neovim's window API
- **`playlist_picker.lua`**: Telescope integration for playlist selection

## 📝 Notes

- The UI updates every 2 seconds by default, which can be configured
- The plugin only works on macOS as it relies on AppleScript to control Apple Music
- Make sure Apple Music is installed and accessible on your system

## 🤝 Contributing

Contributions are welcome! Feel free to submit issues or pull requests on the [GitHub repository](https://github.com/NoamFav/apple_music.nvim).

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📜 License

This plugin is available under the MIT License. See the LICENSE file for more information.

---

<div align="center">

**Happy coding and listening!** 🎵✨

</div>
