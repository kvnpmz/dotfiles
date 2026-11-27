# Bin Scripts Index

A categorized reference for flat scripts residing in `~/bin`.

### Media & Streaming
* **`clean_video.sh`** - Clean/process video metadata for MPV.
* **`imix`** - Image shuffling mix screensaver/player.
* **`mix`** - Controller for imix and vmix.
* **`mpvbg`** - Play looping background video via MPV.
* **`mpvfg`** - Play foreground video via MPV.
* **`mus`** - Shuffle and loop music playlist.
* **`playlist-create`** - Generate a music playlist m3u8 file.
* **`vmix`** - Video mix player from storage.
* **`wpv`** - Multi-pane video grid start.
* **`wpv_control.sh`** - Run video-grid viewer commands with temporary context/layout changes.
* **`igmpv`** - Stream an Instagram user's reels in looping MPV playback.
* **`obs`** - Launch OBS Studio with HiDPI scaling.
* **`yazi-start`** - Launch Yazi file manager.

### File Operations & Hashing
* **`add_guid.sh` / `guid-add`** - Prepend random alphanumeric GUID prefixes to files.
* **`crop_filename.sh`** - Trim filename lengths.
* **`copy_chunks`** - Interactively copy `diff_chunk_a*` files to the clipboard.
* **`find-color`** - Search files for hexadecimal color codes.
* **`truncate-filename`** - Shorten stems of video/image filenames.
* **`fix-media`** - Run fixes on media files.
* **`hash-images` / `hash-videos`** - Generate exact-content SHA-256 manifests (not deduplication): images `jpg`, `jpeg`, `png`, `webp`, `gif`, `heic`, `heif`, `avif`; videos `mp4`, `m4v`, `mov`, `mkv`.
  * Recursive, case-insensitive extension matching; requires GNU find/coreutils.
  * Incremental by default; `--all` forces a complete rehash. Sidecars `image_hashes.cache` / `video_hashes.cache` are Lua-native tab/hex caches, not JSON; reuse requires the same path spelling/root and matching path + size + mtime.
  * Legacy manifests retain `SHA256` + two spaces + path; migration reuses only entries with matching metadata and mtime not newer than the manifest.
  * Newline/CR names are unsupported. A command-line symlink root is followed; nested symlinks are not.
  * Cache replacement precedes manifest replacement, so a failed manifest replacement can leave it temporarily stale until the next run. New manifest mode is `0644`, new cache mode `0600`; existing modes are preserved.
* **`compare-image-hashes` / `compare-video-hashes`** - Compare hash collections.
* **`find-duplicate-hashes`** - Identify duplicate hashes.
* **`find_name_duplicates`** - Group files by prefix name patterns.
* **`move_duplicates`** - Relocate duplicate files found by lists.
* **`move_video.sh`** - Move video files to download destination.
* **`pdf-to-png`** - Convert PDF pages to high-res PNG images.

### System, Desktop & Hardware
* **`autotrash`** - Background daemon to clean old trash files.
* **`bar_toggle`** - Toggle the creek bar and argen status processes.
* **`battery-warning`** - Critical desktop notifications for low battery.
* **`bt`** - Pair, trust, and connect the configured Bluetooth device.
* **`kwim-watcher`** - Monitor udev input events for kwim.
* **`locale-switch`** - Switch system locale/language.
* **`filepicker_reset`** - Reset the GTK file chooser window size.
* **`mirror-tv`** - Mirror displays at 1080p and restart the desktop bar.
* **`myip`** - Show public IPv4/IPv6 addresses or IP details.
* **`portal-kde`** - Run the KDE desktop portal with HiDPI scaling and dark colors.
* **`power_menu`** - Fuzzel-based power management menu.
* **`restart_bar`** - Restart panel/bar components.
* **`river-argen`** - Launch River window manager via D-Bus session.
* **`argen-status-loop.sh`** - Background status loop for argen environment.
* **`rotate_left` / `rotate_right` / `screen_rotate.lua`** - Screen orientation controls.
* **`screenkey-toggle`** - Toggle showmethekey screencast utility.
* **`screenshot`** - Capture screen region to clipboard and file.
* **`smt`** - Void Linux system update and cleanup script.
* **`start_audio.sh`** - Reset and reload Intel audio kernel modules.
* **`sync-etc`** - Sync configuration files listed in `etc-files`.
* **`toggle_red`** - Toggle gammastep color temperature.
* **`usb`** - Locate and mount Storage USB label.
* **`mtp` / `mtp-off`** - Mount or unmount MTP storage devices.
* **`xkb_status` / `xkb_toggle`** - Keyboard layout status and cycler.
* **`context_move.sh`** - Move focused window to a target context.
* **`timezone_change`** - Update system timezone settings.

### Development & Containers
* **`cbt`** - Quick connect to Bluetooth device.
* **`artcraft` / `deckcraft` / `designcraft` / `filmcraft` / `gridcraft` / `pdfcraft` / `photocraft` / `wordcraft`** - Launch the newest matching AppImage from `~/Applications`.
* **`craft_wrap`** - Regenerate the Craft AppImage launch wrappers.
* **`Deemix`** - Launch Deemix development environment.
* **`docker_credentials_push`** - Copy host Azure/Wrangler credentials into a running container.
* **`docker_snap`** - Clean and snapshot a development container image.
* **`dtx`** - Git dotfiles management shortcut.
* **`dwr`** - Dotnet watch run wrapper for TemplatePrintable.
* **`gd`** - Launch Goose with custom compacting and subagent defaults.
* **`edit`** - Open template render files.
* **`jdownloader` / `jdownloader-stop`** - Manage JDownloader Docker container.
* **`Krokiet`** - Run Krokiet with scaled Slint factor.
* **`tpr`** - Run TemplatePrintable tool wrapper.
* **`watchlua` / `watchteal`** - Watch local Lua/Teal files for changes.

### Utilities & Shortcuts
* **`hcat`** - Head/tail wrapper tool.
* **`hc`** - Read a file's first 1000 lines or apply `tail` to stdin/arguments.
* **`calibre`** - Launch Calibre with HiDPI scaling.
* **`etsy_upload`** - Run Etsy project batch uploads.
* **`l`** - Colorized `ls` shorthand.
* **`rm`** - Safe removal wrapper moving files to Gio trash.
* **`v`** - Neovim execution wrapper.
* **`cpln` / `cpy`** - Clipboard copy shortcuts via `wl-copy`.
* **`e1s.sh`** - Zenity language picker phrase copier.
* **`firefox_profile.sh` / `firefox-ram-start`** - Specialized Firefox profile launchers.
* **`ghostty`** - Ghostty terminal wrapper with IM module settings.
* **`okular` / `qpdfview`** - PDF viewers scaled for HiDPI.
* **`trash-restore`** - Restore items from local trash.
* **`tree-clean`** - Clean directory tree ignoring build dirs.
* **`vpn`** - Toggle WireGuard VPN connection (`vpn_nl`).
* **`worldclock`** - Waybar world clock JSON generator.
* **`ssio`** - Launch ShellShock.io in Chromium app mode.
* **`michael_report.sh`** - Generate Michael listing sales report.
* **`nvm`** - Lazy-load Node Version Manager wrapper.
* **`qbg`** - Quiet background task runner with disown.
* **`creek_start`** - Initialize creek topbar.
* **`check-readme`** - Cross-reference bin directory contents with README index.
