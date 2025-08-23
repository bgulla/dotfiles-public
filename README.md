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

## Notes & tips

- **Prompt config**: adjust icons/segments in `~/.p10k.zsh`.  
- **Aliases**: open `~/.aliases` to see and tweak shortcuts; sourced from `~/.zshrc` so changes apply on new shells.  
- **tmux**: status line and keybinds live in `~/.tmux.conf`; reload with `<prefix> :source-file ~/.tmux.conf`.  

---

## License

MIT. See `LICENSE`.
