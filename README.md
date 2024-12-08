# MTSP (Music Terminal Streaming Player)

## Overview
MTSP is an advanced terminal-based music player that allows you to manage your music library with ease. It supports playing local files, streaming from SoundCloud, playlist management, and song searching.

## Key Features
- 🎵 Play local audio files (MP3, FLAC, WAV)
- 🌐 SoundCloud streaming support
- 📋 Playlist management (create, view, add, remove)
- 🔍 Music library search
- 📝 Event logging

## System Requirements
### Required Software
- Bash (Linux or macOS)
- mpv (media player)
- youtube-dl (for SoundCloud streaming)

### Installation
1. Install dependencies:
```bash
sudo apt-get install mpv youtube-dl  # For Debian/Ubuntu-based distributions
```

2. Clone the repository:
```bash
git clone https://github.com/almezali/mtsp.git
cd mtsp
chmod +x mtsp-2.0.1.sh
```

## Usage
### Main Menu Options
1. Play local file
2. Play from SoundCloud
3. Manage playlists
4. Add music from folder
5. Search songs
6. Display help
7. Exit

### Running the Program
```bash
./mtsp-2.0.1.sh
```

## Folder Structure
- `~/Music/`: Default music library directory
- `~/.mtsp/playlists/`: Playlists directory
- `~/.mtsp/mtsp.log`: Log file location

## Playlist Management
- Create new playlists
- View existing playlists
- Add/remove songs from playlists
- Play entire playlists sequentially

## Logging
All actions are logged with timestamps in `~/.mtsp/mtsp.log`

## Contributing
1. Open an issue to report bugs
2. Create a pull request for contributions

## Troubleshooting
- Ensure all dependencies are installed
- Check log file for detailed error information
- Verify file paths and permissions

## License
[FREE]

## Limitations
- Requires internet connection for SoundCloud streaming
- Supports limited audio formats (MP3, FLAC, WAV)

## Future Improvements
- Add support for more streaming platforms
- Implement advanced playlist features
- Enhanced search capabilities
