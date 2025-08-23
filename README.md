# dotfiles-public

> Clean, fast, and repeatable shell vibes. These are my public dotfiles.

## Badges
[![Shell: Zsh](https://img.shields.io/badge/shell-zsh-blue)](https://www.zsh.org/)
[![Prompt: Powerlevel10k](https://img.shields.io/badge/prompt-powerlevel10k-lightgrey)](https://github.com/romkatv/powerlevel10k)
[![License: MIT](https://img.shields.io/badge/license-MIT-informational)](LICENSE)

---

## What this repo gives you

### Shell experience
- **Zsh config (`.zshrc`)** wired up with **Oh My Zsh** for sane defaults and plugins.  
- **zsh-autosuggestions** for ghost-text suggestions as you type.  
- **Powerlevel10k** prompt with a fast, succinct theme driven by `.p10k.zsh`.  
- **Aliases & functions** collected in `.aliases` to speed up day-to-day tasks (wrappers for `git`, `kubectl`, `docker`, navigation, and system introspection).  
- **htop** config (`.htoprc`) with readable meters and process columns.  
- **Krew plugin list** (`.krewplugins`) to standardize your `kubectl krew` environment.  
- **tmux** tuned via `.tmux.conf` with **tmux-power** for a battery/CPU/network-aware status line.

Repo layout highlights: `.aliases`, `.zshrc`, `.p10k.zsh`, `.tmux.conf`, `.htoprc`, plus submodules for `ohmyzsh`, `powerlevel10k`, `zsh-autosuggestions`, and `tmux-power`.

---

## Quick start (with `make dotfiles`)

> Prereqs: `git`, `make`, `zsh`, `tmux`. If you’re cloning fresh, pull submodules too.

```bash
# clone (with submodules)
git clone --recurse-submodules https://github.com/bgulla/dotfiles-public.git ~/.dotfiles-public
cd ~/.dotfiles-public

# install
make dotfiles
```

---

## What `make dotfiles` does

- **Creates symlinks** from your home directory to tracked files in this repo.  
  - Examples (from → to):
    - `~/.dotfiles-public/.zshrc` → `~/.zshrc`
    - `~/.dotfiles-public/.p10k.zsh` → `~/.p10k.zsh`
    - `~/.dotfiles-public/.aliases` → `~/.aliases`
    - `~/.dotfiles-public/.tmux.conf` → `~/.tmux.conf`
    - `~/.dotfiles-public/.htoprc` → `~/.htoprc`
- **Idempotent**: running it again re-links anything missing.  
- **Respects existing files**: if a conflicting file already exists in `$HOME`, the target is backed up (e.g., `filename.bak`) before linking.

The repo includes a `Makefile` that drives the install; use:

```bash
git submodule update --init --recursive
```

to keep bundled plugins (ohmyzsh, powerlevel10k, zsh-autosuggestions, tmux-power) in sync.

---

## Updating

```bash
cd ~/.dotfiles-public
git pull --recurse-submodules
git submodule update --init --recursive
make dotfiles
```

---

# iTerm2 “Black Magic” (Prefs from GitHub Pages + Remote Theme Switching)

This repo serves iTerm2 preferences **directly from GitHub Pages** so every Mac can load the same settings without manual imports. It also includes an SSH trick that switches to a special “remote-ssh” theme **when you connect to certain hosts**.

## How it works

- iTerm2 can **load preferences from a folder or URL**.  
- We host the live prefs file, `com.googlecode.iterm2.plist`, at:

  ```
  https://bgulla.github.io/dotfiles-public/iterm/
  ```

  > ⚠️ iTerm2 expects a **folder URL**. Internally it appends `com.googlecode.iterm2.plist`.  
  > Don’t point iTerm at the file URL; use the **folder** URL above.

- Profiles/colors (themes) are embedded in the plist. Once you apply a color preset to a profile, those RGB values live inside the plist—no separate `.itermcolors` needed for syncing (though you can keep them here for convenience).

## One-time setup (per Mac)

**GUI way:**  
`iTerm2 → Preferences → General → Preferences`  
✔ **Load preferences from a custom folder or URL**  
URL: `https://bgulla.github.io/dotfiles-public/iterm/`  
(Leave “Save changes to folder when iTerm2 quits” **unchecked** for URL mode.)

**CLI way (good for bootstrap scripts):**
```zsh
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "https://bgulla.github.io/dotfiles-public/iterm/"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
```

### Optional: auto-set on interactive shells (macOS; specific users)
Add to `~/.zshrc` (adjust username checks if needed):
```zsh
# iTerm2: load prefs from GitHub Pages (mac-only; user=brandon|bgulla)
if [[ $- == *i* ]] && [[ "$OSTYPE" == darwin* ]] && [[ "$USER" == "brandon" || "$USER" == "bgulla" ]]; then
  ITERM_PREFS_URL="https://bgulla.github.io/dotfiles-public/iterm/"
  if [[ "$TERM_PROGRAM" == "iTerm.app" ]] || /usr/bin/defaults domains 2>/dev/null | /usr/bin/grep -q com.googlecode.iterm2; then
    current=$(/usr/bin/defaults read com.googlecode.iterm2 PrefsCustomFolder 2>/dev/null || echo "")
    if [[ "$current" != "$ITERM_PREFS_URL" ]]; then
      /usr/bin/defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$ITERM_PREFS_URL"
      /usr/bin/defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
      print -P "%F{cyan}[iTerm2]%f Prefs set to GitHub Pages. Restart iTerm2 to apply."
    fi
  fi
fi
```

## Updating the synced plist (what to run after you change settings)

When you tweak iTerm settings on a Mac and want to push them to all machines:

> Replace `~/src/dotfiles-public` with your local clone path.

```zsh
# 1) Export the running prefs to the repo path
mkdir -p ~/src/dotfiles-public/iterm
defaults export com.googlecode.iterm2 ~/src/dotfiles-public/iterm/com.googlecode.iterm2.plist

# (Optional) ensure pretty XML (usually not needed; defaults export is XML)
# plutil -convert xml1 ~/src/dotfiles-public/iterm/com.googlecode.iterm2.plist

# 2) Commit & push
cd ~/src/dotfiles-public
git add iterm/com.googlecode.iterm2.plist
git commit -m "Update iTerm2 prefs"
git push
```

Once the commit is live, iTerm will pick it up on next launch (or after toggling the load setting).

## Remote SSH theme switching (the “cotton candy/remote-ssh” vibe)

iTerm2 understands special escape sequences. We use a **local** `ssh_config` hook to switch profile **right before** connecting to matching hosts.

Add this block to your `~/.ssh/config`:

```ssh-config
# Swap the TLD/internal-domain as needed (e.g., *.dev, *.corp, *.internal).
# Example below matches any host ending in ".lol".
Host *lol
    PermitLocalCommand yes
    LocalCommand printf '\033]1337;SetProfile=remote-ssh\007'
```

- Replace `*lol` with the pattern you want (e.g., `*dev`, `*corp`, `*.internal`).
- Create an iTerm **Profile** named `remote-ssh` with your preferred “trippy cotton candy” colors.
- When you connect to matching hosts, iTerm switches to that profile automatically.
- To revert to your default theme when SSH exits, wrap `ssh` in your shell (optional):

  ```zsh
  # ~/.zshrc
  ssh() {
    printf '\033]1337;SetProfile=remote-ssh\007'
    command ssh "$@"
    printf '\033]1337;SetProfile=Default\007'
  }
  ```

  (Adjust `Default` to your actual base profile name if different.)

## Repo layout

```
dotfiles-public/
└─ iterm/
   ├─ com.googlecode.iterm2.plist        # live prefs (consumed by iTerm over HTTPS)
   ├─ DynamicProfiles/                   # optional JSON profiles (auto-loaded by iTerm)
   └─ ColorSchemes/                      # optional .itermcolors for manual import
```

> Tip: Themes you’ve already applied to Profiles are embedded in the plist. Keeping `.itermcolors` here is just for your convenience.

## Notes & gotchas

- **Folder vs File URL:** set iTerm to the **folder** (`…/iterm/`), not the plist file.
- **Read-only via Pages:** iTerm can’t write back to the URL; use the **update commands** above to publish changes.
- **Fonts aren’t synced:** install your terminal fonts on each Mac (e.g., Meslo/JetBrainsMono Nerd Font).
- **Security:** keep secrets out of profiles; this repo is public.


---

## Notes & tips

- **Prompt config**: adjust icons/segments in `~/.p10k.zsh`.  
- **Aliases**: open `~/.aliases` to see and tweak shortcuts; sourced from `~/.zshrc` so changes apply on new shells.  
- **tmux**: status line and keybinds live in `~/.tmux.conf`; reload with `<prefix> :source-file ~/.tmux.conf`.  

---

## License

MIT. See `LICENSE`.
