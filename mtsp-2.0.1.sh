#!/bin/bash

# MTSP - Music Terminal Streaming Player
# Version 2.0.1
MUSIC_DIR="$HOME/Music"
PLAYLIST_DIR="$HOME/.mtsp/playlists"
CONFIG_FILE="$HOME/.mtsp/config"
LOG_FILE="$HOME/.mtsp/mtsp.log"

# Ensure required directories exist
mkdir -p "$PLAYLIST_DIR"
mkdir -p "$(dirname "$LOG_FILE")"

# Logging function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Function to play a local audio file
play_local_file() {
    if [ -f "$1" ]; then
        log "Playing local file: $1"
        mpv "$1"
    else
        echo "File not found: $1"
        log "Error: File not found: $1"
    fi
}

# Function to play from SoundCloud
play_soundcloud() {
    echo "Playing from SoundCloud: $1"
    log "Playing SoundCloud URL: $1"
    youtube-dl -o - "$1" | mpv -
}

# Function to manage playlists
manage_playlists() {
    while true; do
        echo "Playlist Management"
        echo "1. Create new playlist"
        echo "2. View playlists"
        echo "3. Add song to playlist"
        echo "4. Remove song from playlist"
        echo "5. Play playlist"
        echo "6. Back to main menu"
        read -p "Enter your choice: " choice
        case $choice in
            1) create_playlist ;;
            2) view_playlists ;;
            3) add_to_playlist ;;
            4) remove_from_playlist ;;
            5) play_playlist ;;
            6) return ;;
            *) echo "Invalid choice" ;;
        esac
    done
}

# Function to create a new playlist
create_playlist() {
    read -p "Enter playlist name: " playlist_name
    touch "$PLAYLIST_DIR/$playlist_name.txt"
    echo "Playlist '$playlist_name' created."
    log "Created playlist: $playlist_name"
}

# Function to view playlists
view_playlists() {
    echo "Available playlists:"
    ls -1 "$PLAYLIST_DIR"
}

# Function to add a song to a playlist
add_to_playlist() {
    read -p "Enter playlist name: " playlist_name
    read -p "Enter song path: " song_path
    echo "$song_path" >> "$PLAYLIST_DIR/$playlist_name.txt"
    echo "Song added to playlist '$playlist_name'"
    log "Added song to playlist: $playlist_name - $song_path"
}

# Function to remove a song from a playlist
remove_from_playlist() {
    read -p "Enter playlist name: " playlist_name
    if [ -f "$PLAYLIST_DIR/$playlist_name.txt" ]; then
        cat -n "$PLAYLIST_DIR/$playlist_name.txt"
        read -p "Enter song number to remove: " song_number
        sed -i "${song_number}d" "$PLAYLIST_DIR/$playlist_name.txt"
        echo "Song removed from playlist '$playlist_name'"
        log "Removed song #$song_number from playlist: $playlist_name"
    else
        echo "Playlist not found."
    fi
}

# Function to play a playlist
play_playlist() {
    read -p "Enter playlist name: " playlist_name
    if [ -f "$PLAYLIST_DIR/$playlist_name.txt" ]; then
        log "Playing playlist: $playlist_name"
        while IFS= read -r song
        do
            play_local_file "$song"
        done < "$PLAYLIST_DIR/$playlist_name.txt"
    else
        echo "Playlist not found."
        log "Error: Playlist not found: $playlist_name"
    fi
}

# Function to add music from a folder
add_from_folder() {
    read -p "Enter folder path: " folder_path
    if [ -d "$folder_path" ]; then
        find "$folder_path" -type f \( -name "*.mp3" -o -name "*.flac" -o -name "*.wav" \) -exec cp {} "$MUSIC_DIR" \;
        echo "Music files added to library."
        log "Added music files from folder: $folder_path"
    else
        echo "Folder not found: $folder_path"
        log "Error: Folder not found: $folder_path"
    fi
}

# Function to search for songs
search_songs() {
    read -p "Enter search term: " search_term
    echo "Searching for '$search_term' in $MUSIC_DIR"
    find "$MUSIC_DIR" -type f \( -name "*.mp3" -o -name "*.flac" -o -name "*.wav" \) -iname "*$search_term*"
}

# Function to display help
display_help() {
    echo "MTSP Help (Version 2.0.1)"
    echo "1. Play local file: Plays an audio file from your local storage."
    echo "2. Play from SoundCloud: Streams and plays a track from SoundCloud."
    echo "3. Manage playlists: Create, view, and modify playlists."
    echo "4. Add music from folder: Add music files from a specified folder to your library."
    echo "5. Search songs: Search for songs in your music library."
    echo "6. Display help: Shows this help message."
    echo "7. Exit: Quits the program."
}

# Main menu
main_menu() {
    while true; do
        echo "MTSP - Music Terminal Streaming Player (v2.0.1)"
        echo "1. Play local file"
        echo "2. Play from SoundCloud"
        echo "3. Manage playlists"
        echo "4. Add music from folder"
        echo "5. Search songs"
        echo "6. Display help"
        echo "7. Exit"
        read -p "Enter your choice: " choice
        case $choice in
            1)
                read -p "Enter file path: " file_path
                play_local_file "$file_path"
                ;;
            2)
                read -p "Enter SoundCloud URL: " soundcloud_url
                play_soundcloud "$soundcloud_url"
                ;;
            3)
                manage_playlists
                ;;
            4)
                add_from_folder
                ;;
            5)
                search_songs
                ;;
            6)
                display_help
                ;;
            7)
                echo "Thanks for using MTSP!"
                log "Program exited"
                exit 0
                ;;
            *)
                echo "Invalid choice"
                ;;
        esac
    done
}

# Start the program
log "MTSP started"
main_menu
