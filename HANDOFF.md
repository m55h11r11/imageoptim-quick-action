# Handoff: ImageOptim Quick Action

## What was built
A macOS Finder Quick Action that lets you right-click any image(s) and optimize them via ImageOptim in one click.

## How it works
- The workflow (`Optimize Images.workflow`) is an Automator Quick Action that runs an AppleScript
- The AppleScript tells ImageOptim to open the selected files, which triggers auto-optimization
- Lossy compression is configured via `defaults write` for 50-70% savings (similar to TinyPNG)

## Key files
- `Optimize Images.workflow/` — Automator Quick Action bundle
- `install.sh` — Installs ImageOptim, imageoptim-cli, configures compression, registers the Quick Action
- `uninstall.sh` — Removes the Quick Action
- `README.md` — User-facing docs

## How the Quick Action registers
macOS is strict about `.workflow` bundles — manually copying to `~/Library/Services/` often doesn't register them. The install script uses `open` on the workflow file, which triggers macOS's built-in workflow installer dialog. The user clicks "Install" and macOS handles registration properly.

## Compression config (stored in macOS defaults)
```
net.pornel.ImageOptim LossyEnabled = true
net.pornel.ImageOptim JpegOptimMaxQuality = 80
net.pornel.ImageOptim PngMinQuality = 40
net.pornel.ImageOptim PngMaxQuality = 80
```

## Dependencies
- Homebrew
- ImageOptim (installed via `brew install --cask imageoptim`)
- imageoptim-cli (installed via `brew install imageoptim-cli`)

## Known quirks
- The workflow was originally cloned from a Yoink workflow and modified — it still has Yoink's custom icon embedded in `document.wflow` (cosmetic, doesn't affect functionality)
- Quarantine xattrs must be stripped (`xattr -cr`) before `open` or macOS blocks the installer
- If the Quick Action doesn't appear after install, `killall Finder` or a logout/login is needed
