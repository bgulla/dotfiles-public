# Dotfiles

[![Made with 🥲](https://img.shields.io/badge/Made%20with-%E2%9D%A4-red)](https://github.com/bgulla/dotfiles-public)
[![Shell](https://img.shields.io/badge/shell-zsh-89e051.svg)](https://www.zsh.org/)
[![macOS](https://img.shields.io/badge/OS-macOS-lightgrey.svg)](https://www.apple.com/macos/)
[![Linux](https://img.shields.io/badge/OS-Linux-yellow.svg)](https://www.kernel.org/)
[![License](https://img.shields.io/github/license/bgulla/dotfiles-public)](./LICENSE)

This repo contains my personal dotfiles for macOS and Linux. It standardizes shell behavior, terminal settings, and other environment tweaks across all my machines.

---

## Usage

Clone the repo into your home directory and use `make` to apply:

```sh
git clone https://github.com/bgulla/dotfiles-public ~/dotfiles-public
cd ~/dotfiles-public
make dotfiles
```

The `Makefile` takes care of symlinking configs into `~` and applying defaults.  

---

## iTerm2 Magic ✨

On macOS, iTerm2 is wired up to load its preferences straight from this repo so changes stay in sync automatically.  

There’s also a bit of SSH magic: when you connect to certain hosts (like `*.lol`), iTerm will switch to a different profile with a distinct theme. That way you always know at a glance when you’re on a remote box — and it flips back when you disconnect.  If you have custom themes and settings in iTerm, this will probably b0rk them.

---

These dotfiles are meant to be portable, easy to apply, and give me a consistent environment no matter where I’m working.
