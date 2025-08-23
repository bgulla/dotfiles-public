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
- **Aliases & functions** collected in `.aliases` to speed up day-to-day tasks (quality-of-life wrappers around `git`, `kubectl`, `docker`, navigation, and quick system introspection).  
- **htop** config (`.htoprc`) with readable meters and process columns.  
- **Krew plugin list** (`.krewplugins`) to standardize your `kubectl krew` environment.  
- **tmux** tuned via `.tmux.conf` with **tmux-power** for a battery/CPU/network-aware status line.

> Repo layout highlights: `.aliases`, `.zshrc`, `.p10k.zsh`, `.tmux.conf`, `.htoprc`, plus submodules for `ohmyzsh`, `powerlevel10k`, `zsh-autosuggestions`, and `tmux-power`. :contentReference[oaicite:0]{index=0}

---

## Quick start (with `make dotfiles`)

> Prereqs: `git`, `make`, `zsh`, `tmux`. If you’re cloning fresh, pull submodules too.

```bash
# clone (with submodules)
git clone --recurse-submodules https://github.com/bgulla/dotfiles-public.git ~/.dotfiles-public
cd ~/.dotfiles-public

# install
make dotfiles
