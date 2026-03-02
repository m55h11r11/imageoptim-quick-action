# ImageOptim Quick Action for macOS

Right-click any image(s) in Finder → **Quick Actions → Optimize Images** to compress them instantly via [ImageOptim](https://imageoptim.com).

## What it does

- Adds an **"Optimize Images"** option to Finder's right-click Quick Actions menu
- Opens selected images in ImageOptim which auto-optimizes them in place
- Configures lossy compression (JPEG 80%, PNG 40-80%) for **50-70% file size savings** — similar to TinyPNG

## Install

```bash
chmod +x install.sh && ./install.sh
```

This will:
1. Install **ImageOptim** and **imageoptim-cli** via Homebrew (if not already installed)
2. Copy the Quick Action workflow to `~/Library/Services/`
3. Configure ImageOptim for optimal lossy compression

### Setting up the Quick Action (recommended)

The install script copies the workflow file, but macOS may not register it automatically. If "Optimize Images" doesn't appear in Quick Actions after running `killall Finder` or logging out/in, create it manually — takes 30 seconds:

1. Open **Automator** (Spotlight → type "Automator")
2. Click **New Document** → choose **Quick Action**
3. Set **"Workflow receives current"** to **files or folders** in **Finder**
4. Drag **"Run AppleScript"** from the left sidebar into the workflow area
5. Replace the script with:
   ```applescript
   on run {input, parameters}
       tell application "ImageOptim" to open input
   end run
   ```
6. **Cmd+S** → save as **"Optimize Images"**

Done — now right-click any image → Quick Actions → Optimize Images

## Uninstall

```bash
chmod +x uninstall.sh && ./uninstall.sh
```

## Compression settings

| Setting | Value |
|---|---|
| Mode | Lossy |
| JPEG quality | 80% |
| PNG quality | 40–80% |

To switch back to lossless:
```bash
defaults write net.pornel.ImageOptim LossyEnabled -bool false
```

## Requirements

- macOS 12+ (Monterey or later)
- [Homebrew](https://brew.sh)
