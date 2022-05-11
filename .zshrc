############################################
# Oh-My-Zsh stuff
############################################
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=6

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Tmux autostart
ZSH_TMUX_AUTOSTART="false"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many)
plugins=(git fzf)

source $ZSH/oh-my-zsh.sh

############################################
# Aliases
############################################
alias e='exit'
alias nv='nvim'
alias gpl='git log --pretty=format:"%C(yellow)%h %Cblue%>(12)%ad %Cgreen%<(7)%aN%Cred%d %Creset%s"'
alias dh='dirs -v'
alias r='ranger'
alias nvcfg='nvim ~/.config/nvim/init.vim'
alias lhalt='ls -halt'
alias ll='ls -l'
alias l='ls -1'
alias rg="rg --colors 'path:fg:yellow'"
alias vim="nvim"
alias t="true" # Solves an annoying bug displaying return codes in the shell
alias vd="nvim -S Session.vim"
alias spd="pandoc --reference-links" # Short for "standard pandoc"
alias mcm="make clean && compiledb make -j8" # Short for make clean && make
if [ -x "$(command -v trash-put)" ]; then
	alias rm="trash-put"
else
	alias rm="rm -i"
fi

############################################
# Environment vars
############################################
export RIPGREP_CONFIG_PATH=~/.config/ripgrep/ripgrep.conf
export EDITOR=nvim
export VIEWER="vim -R"
# This is dirty, but necessary on some systems that construct weird loacles
# If this is not set, some terminal programs might screw up
export LANG=en_US.UTF-8

############################################
# Sourced Files
############################################
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -e ~/bin ] && export PATH=$HOME/bin:$PATH
# Also use the /opt folder for optional files
export PATH=$PATH:/opt
[ -f /usr/lib/ccache ] && export PATH=/usr/lib/ccache:$PATH

# Iterm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Homebrew shell completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

############################################
# Functions and quirks
############################################
# Print empty line before printing prompt; makes series of long outputs easier to read
precmd() { print "" }
# Highlight first ambiguous character in tab-complete
zstyle ':completion:*' show-ambiguity "$color[fg-red]"
zstyle ':completion:*' completer _expand_alias _complete _ignored

############################################
# General zsh flags
############################################

# Prepare the zmv rename utility
autoload zmv

# Display red dots while waiting for completion
COMPLETION_WAITING_DOTS="true"

# why would you type 'cd dir' if you could just type 'dir'?
setopt AUTO_CD

# Now we can pipe to multiple outputs!
setopt MULTIOS

# This will use named dirs when possible
setopt AUTO_NAME_DIRS

# If we have a glob this will expand it
setopt GLOB_COMPLETE

# No more annoying pushd messages...
setopt PUSHD_SILENT

# blank pushd goes to home
setopt PUSHD_TO_HOME

# 10 second wait if you do something that will delete everything.  I wish I'd had this before...
setopt RM_STAR_WAIT

############################################
# History
############################################

# Remember about a years worth of history (AWESOME)
SAVEHIST=10000
HISTSIZE=12000

# Don't overwrite, append!
setopt APPEND_HISTORY

# Killer: share history between multiple shells
setopt SHARE_HISTORY

# If I type cd and then cd again, only save the last one
setopt HIST_IGNORE_DUPS

# Even if there are commands inbetween commands that are the same, still only save the last one
setopt HIST_IGNORE_ALL_DUPS

# Pretty Obvious.  Right?
setopt HIST_REDUCE_BLANKS

# If a line starts with a space, don't save it.
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE

# When using a hist thing, make a newline show the change before executing it.
setopt HIST_VERIFY

setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

############################################
# Functions
############################################

_force_rehash() {
  (( CURRENT == 1 )) && rehash
  return 1
}

