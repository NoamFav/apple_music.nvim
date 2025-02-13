# Apple Music Neovim Plugin

A Neovim plugin for controlling **Apple Music** directly from Neovim. This plugin provides a floating UI that displays the current track and allows you to control playback (Play/Pause, Next, Previous) and adjust the volume using Neovim key mappings.

---

## Features

- **Floating Music UI**: Displays the current track with volume information in a top-right floating window.
- **Music Control**: Play, pause, skip tracks, and adjust volume.
- **Key Mappings**: Control music with customizable key mappings.
- **Persistent Updates**: The UI updates every 2 seconds to show the latest track information.

---

## Installation

### Requirements

- **Neovim 0.7+**
- **macOS** (since it relies on `osascript` to control Apple Music)

### Using [Lazy.nvim](https://github.com/folke/lazy.nvim)

Add the repository to your Neovim configuration.

---

## Installation

### Lazy.nvim

Add the repository to your `lazy.nvim` configuration:

```lua
{
  "NoamFav/apple_music.nvim"
}
```

### Packer.nvim

```lua
use "NoamFav/apple_music.nvim"
```

### Vim-Plug

```vim
Plug 'NoamFav/apple_music.nvim'
```

---

## Usage

### Commands

- `:MusicControl`: Opens the floating music control UI.
- `:FocusMusicUI`: Focuses on the floating window (or returns focus to the previous window).

### Key Mappings

The plugin includes the following key mappings by default:

- `<Leader>mu`: Open Music Control UI
- `<Leader>mp`: Play/Pause Music
- `<Leader>mn`: Next Track
- `<Leader>mb`: Previous Track
- `<Leader>m+`: Increase Volume
- `<Leader>m-`: Decrease Volume
- `<Leader>mq`: Close Music Control UI
- `<Leader>mm`: Focus Music UI

---

## Development

### File Structure

- **`init.lua`**: Entry point for the plugin, initializes commands and key mappings.
- **`music_control.lua`**: Contains functions for controlling Apple Music (play, pause, next, previous, volume control).
- **`music_ui.lua`**: Defines the floating UI for displaying track information and handling updates.

### Recursive UI Updates

The UI updates every 1 seconds to display the latest track information. This ensures that the displayed track and volume levels are always accurate.

---

## License

This plugin is open-source and available under the MIT License.
