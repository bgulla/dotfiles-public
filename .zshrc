# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/dotfiles/ohmyzsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"
HIST_STAMPS="mm/dd/yyyy"
HISTTIMEFORMAT="%F %T "

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker docker-compose kubectl 1password ansible brew pip rsync sigstore tmux tmuxinator helm kube-ps1)

#source $ZSH/oh-my-zsh.sh
source ${HOME}/dotfiles/ohmyzsh/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


ZSH_THEME="powerlevel10k/powerlevel10k"
source ~/dotfiles/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/brandon/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
autoload -U compinit && compinit

# fix the scp glob error
setopt nonomatch

## load the autocompleter
source ~/dotfiles/zsh-autosuggestions/zsh-autosuggestions.zsh
export PATH="/Users/brandon/bin:/Users/brandon/.rd/bin:$PATH"

export XDG_CONFIG_HOME=~/.config

[ -f .aliases ] && source .aliases

## Autocomplete stuff
if command -v velero >/dev/null 2>&1; then
  source <(velero completion zsh)
  alias v=velero
fi
### EOAutocomplete

# k3s/rke2 auto kubeconfig-ifying
if [ -f "/etc/rancher/k3s/k3s.yaml" ]; then
  export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
elif [ -f "/etc/rancher/rke2/rke2.yaml" ]; then
  export KUBECONFIG=/etc/rancher/rke2/rke2.yaml
fi


## Add rust if the bin folder exists
#cargo install tpi

if [ -d "$HOME/.cargo/bin" ]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi


# _____ _   _ ____  ___ _   _  ____
#|_   _| | | |  _ \|_ _| \ | |/ ___|
#  | | | | | | |_) || ||  \| | |  _
#  | | | |_| |  _ < | || |\  | |_| |
#  |_|  \___/|_| \_\___|_| \_|\____|

function tpi-cli() {
    local user="root"  # Define the user variable
    local password="${TURING_PW}"  # Read the password from the environment variable
    local board_host="board1.tpi.l0l0.lol"  # Default host
    local args=()  # Array to hold the arguments we will pass to tpi
    
    # Loop through the arguments to find --board=<value>
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --board=*)
                board_value="${1#*=}"  # Extract the value after '='
                case "$board_value" in
                    1)
                        echo "[defaulting to board 1]"
                        board_host="board1.tpi.l0l0.lol"
                        ;;
                    2)
                        echo "[defaulting to board 2]"
                        board_host="board1.tpi.l0l0.lol"
                        ;;
                    *)
                        echo "[defaulting to board 1]"
                        board_host="board1.tpi.l0l0.lol"
                        ;;
                esac
                shift  # Skip this argument (as it was --board=<value>)
                ;;
            *)
                args+=("$1")  # Add the argument to args if it's not --board
                shift  # Move to the next argument
                ;;
        esac
    done

    # Check if the password is set
    if [[ -z "$password" ]]; then
        echo "Error: TURING_PW environment variable is not set."
        return 1
    fi

    # Execute tpi with the appropriate host, user, password, and remaining arguments
    tpi --user="$user" --password="$password" --host="$board_host" "${args[@]}"
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Check if the system is macOS
if [[ "$(uname)" == "Darwin" ]]; then
    # macOS specific settings
    export PATH="/opt/homebrew/bin:$PATH"
else
    # Linux specific settings
    # You can add Linux-specific PATH modifications here if needed
    export PATH="$PATH"
fi

# --- iTerm2 local sync + SSH include (mac-only; users: brandon|bgulla) ---

# === Config ===
ITERM_DEBUG=${ITERM_DEBUG:-0}                        # 1=debug logs, 0=quiet
SSH_HOST_PATTERN="${SSH_HOST_PATTERN:-*lol}"         # wildcard for hosts (*.lol, *.corp, *.internal)
SSH_ITERM_PROFILE="${SSH_ITERM_PROFILE:-remote-ssh}" # iTerm profile name to switch to

# Detect dotfiles repo
if [[ -d "$HOME/dotfiles-public/iterm" ]]; then
  ITERM_REPO_DIR="$HOME/dotfiles-public"
elif [[ -d "$HOME/dotfiles/iterm" ]]; then
  ITERM_REPO_DIR="$HOME/dotfiles"
else
  ITERM_REPO_DIR=""
fi

ITERM_FOLDER_PATH="${ITERM_REPO_DIR:+$ITERM_REPO_DIR/iterm}"
ITERM_PLIST_PATH="${ITERM_FOLDER_PATH:+$ITERM_FOLDER_PATH/com.googlecode.iterm2.plist}"
SSH_INCLUDE_FILE="${ITERM_REPO_DIR:+$ITERM_REPO_DIR/ssh/iterm-include.conf}"

[[ $ITERM_DEBUG == 1 ]] && echo "[DEBUG] repo='$ITERM_REPO_DIR' folder='$ITERM_FOLDER_PATH' plist='$ITERM_PLIST_PATH' include='$SSH_INCLUDE_FILE'"

# Gate: only run if macOS + correct user + repo exists
if [[ -n "$ITERM_REPO_DIR" ]] && [[ "$OSTYPE" == darwin* ]] && [[ "$USER" == "brandon" || "$USER" == "bgulla" ]]; then

  # --- iTerm setup ---
  iterm_setup() {
    if [[ ! -d "$ITERM_FOLDER_PATH" ]]; then
      echo "[iTerm2] Folder not found: $ITERM_FOLDER_PATH"; return 1
    fi
    if [[ "$TERM_PROGRAM" != "iTerm.app" ]] && ! ( /usr/bin/defaults domains 2>/dev/null | grep -q com.googlecode.iterm2 ); then
      [[ $ITERM_DEBUG == 1 ]] && echo "[DEBUG] iTerm prefs domain not present yet; launch iTerm once then re-run"
      return 0
    fi
    local current=$(/usr/bin/defaults read com.googlecode.iterm2 PrefsCustomFolder 2>/dev/null || echo "")
    [[ $ITERM_DEBUG == 1 ]] && echo "[DEBUG] current_pref='$current' target='$ITERM_FOLDER_PATH'"
    if [[ "$current" != "$ITERM_FOLDER_PATH" ]]; then
      /usr/bin/defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$ITERM_FOLDER_PATH"
      /usr/bin/defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
      echo "[iTerm2] PrefsCustomFolder set → $ITERM_FOLDER_PATH (restart iTerm2)"
    else
      [[ $ITERM_DEBUG == 1 ]] && echo "[DEBUG] PrefsCustomFolder already correct"
    fi
  }

  # Export current prefs → repo copy (XML)
  iterm_export() {
    mkdir -p "$ITERM_FOLDER_PATH" || { echo "[iTerm2] mkdir failed: $ITERM_FOLDER_PATH"; return 1; }
    echo "[iTerm2] Exporting prefs…"
    echo "[DEBUG] dest='$ITERM_PLIST_PATH'"
    /usr/bin/defaults export com.googlecode.iterm2 "$ITERM_PLIST_PATH" || { echo "[iTerm2] defaults export failed"; return 1; }
    /usr/bin/plutil -convert xml1 "$ITERM_PLIST_PATH" 2>/dev/null
    if /usr/bin/plutil -lint "$ITERM_PLIST_PATH" >/dev/null; then
      echo "[iTerm2] Exported → $ITERM_PLIST_PATH"
    else
      echo "[iTerm2] WARNING: plist failed validation at $ITERM_PLIST_PATH"
    fi
  }

  # Test the LOCAL plist
  iterm_test() {
    if [[ ! -f "$ITERM_PLIST_PATH" ]]; then
      echo "[iTerm2] Plist not found: $ITERM_PLIST_PATH"; return 1
    fi
    echo "[iTerm2] Linting $ITERM_PLIST_PATH"
    if /usr/bin/plutil -lint "$ITERM_PLIST_PATH" >/dev/null; then
      echo "[iTerm2] OK: Valid plist"
    else
      echo "[iTerm2] FAIL: Invalid plist"
    fi
  }

  # Revert to ~/Library prefs
  iterm_revert_local() {
    /usr/bin/defaults delete com.googlecode.iterm2 PrefsCustomFolder 2>/dev/null
    /usr/bin/defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool false
    echo "[iTerm2] Reverted to local prefs. Restart iTerm2."
  }

  # --- SSH include setup ---
  ssh_include_setup() {
    mkdir -p "$(dirname "$SSH_INCLUDE_FILE")"

    # Ensure ~/.ssh/config exists
    [[ -f "$HOME/.ssh/config" ]] || touch "$HOME/.ssh/config"

    # Ensure Include line present
    if ! grep -qF "$SSH_INCLUDE_FILE" "$HOME/.ssh/config"; then
      echo -e "\n# iTerm profile switching rules\nInclude $SSH_INCLUDE_FILE" >> "$HOME/.ssh/config"
      echo "[SSH] Added Include → $SSH_INCLUDE_FILE in ~/.ssh/config"
    else
      [[ $ITERM_DEBUG == 1 ]] && echo "[DEBUG] ~/.ssh/config already includes $SSH_INCLUDE_FILE"
    fi

    # Write the include file
    cat > "$SSH_INCLUDE_FILE" <<EOF
# Auto-generated iTerm SSH include
Host $SSH_HOST_PATTERN
    PermitLocalCommand yes
    Match exec "test -t 0"
        LocalCommand printf '\033]1337;SetProfile=$SSH_ITERM_PROFILE\007'
EOF
    # echo "[SSH] Wrote $SSH_INCLUDE_FILE"
  }

  # Auto-run iTerm + SSH setup on interactive shells
  if [[ $- == *i* ]]; then
    iterm_setup
    ssh_include_setup
  fi

else
  [[ $ITERM_DEBUG == 1 ]] && echo "[DEBUG] Skipping iTerm/SSH sync (repo='$ITERM_REPO_DIR' ostype='$OSTYPE' user='$USER')" # edit this line if you're not Brandon
fi

# --- end ---

# ============================================================================
# pfetch - Display system info once per day on first interactive shell login
# ============================================================================
# This runs pfetch (a minimal system info tool) only once per day when you
# first log into a server or open a new terminal session. It won't interfere
# with scp/rsync because it only runs in interactive shells.
#
# How it works:
# 1. Checks if the shell is interactive (not a script or file transfer)
# 2. Checks if pfetch-wrapper command exists
# 3. Creates a timestamp file (~/.pfetch_last_run) with today's date
# 4. Only runs pfetch if the timestamp doesn't exist or is from a previous day
# 5. Updates the timestamp after running so it won't run again today
#
# Custom features (via pfetch-wrapper):
# - Shows IP address of the server
# - Detects if Kubernetes (k3s or rke2) is installed on the node
# ============================================================================

if [[ -o interactive ]] && command -v pfetch-wrapper &> /dev/null && [[ ! -f "${HOME}/.disablepfetch" ]]; then
    PFETCH_STAMP_FILE="${HOME}/.pfetch_last_run"     # Timestamp file location
    TODAY=$(date +%Y-%m-%d)                           # Current date (YYYY-MM-DD)

    # Check if we haven't run pfetch today yet
    if [[ ! -f "$PFETCH_STAMP_FILE" ]] || [[ "$(cat "$PFETCH_STAMP_FILE" 2>/dev/null)" != "$TODAY" ]]; then
        pfetch-wrapper                                # Run the custom pfetch wrapper
        echo "$TODAY" > "$PFETCH_STAMP_FILE"         # Save today's date to prevent re-running
    fi
fi
