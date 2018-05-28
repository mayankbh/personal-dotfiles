# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#

#Update PATH for ruby gems
export PATH="/home/mayankbh/.gem/ruby/2.3.0/bin:$PATH"


# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
 DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(git)
plugins=(history-substring-search)


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

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

case $- in *i*)
	  if [ -z "$TMUX" ]; then exec tmux; fi;;
  esac

source $ZSH/oh-my-zsh.sh

#For running ssh-agent using systemd
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

#For blue waters project
export PROJECT_HOME=/home/mayankbh/Academics/Spring2017/CS525/Project/yosub-code

#Vim bindings
bindkey -v
#Fix delay
export KEYTIMEOUT=1

#function zle-line-init zle-keymap-select {
#    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
#    RPS2=$RPS1
#    zle reset-prompt
#}
#
#zle -N zle-line-init
#zle -N zle-keymap-select
#

#   precmd() {
#	  RPROMPT=""
#	}
#	zle-keymap-select() {
#	  RPROMPT=""
#	  [[ $KEYMAP = vicmd ]] && RPROMPT="(CMD)"
#	  () { return $__prompt_status }
#	  zle reset-prompt
#	}
#	zle-line-init() {
#	  typeset -g __prompt_status="$?"
#	}
#	zle -N zle-keymap-select
#	zle -N zle-line-init
#	
#	bindkey '^R' history-incremental-pattern-search-backward
#	bindkey -M vicmd '/' history-incremental-pattern-search-backward
#	bindkey -M vicmd '?' history-incremental-pattern-search-forward
#	bindkey -M viins '^R' history-incremental-pattern-search-backward
#	bindkey -M viins '^F' history-incremental-pattern-search-forward
#	

# vim mode indicator in prompt (http://superuser.com/questions/151803/how-do-i-customize-zshs-vim-mode)
vim_ins_mode="%{$fg[cyan]%}[INS]%{$reset_color%}"
vim_cmd_mode="%{$fg[green]%}[CMD]%{$reset_color%}"
vim_mode=$vim_ins_mode

# background jobs indicator in prompt (https://gist.github.com/remy/6079223)
function background_jobs() {
  [[ $(jobs -l | wc -l) -gt 0 ]] && echo "⚙"
}

# online indicator in prompt (https://gist.github.com/remy/6079223)
ONLINE="%{%F{green}%}◉%{$reset_color%}"
OFFLINE="%{%F{red}%}⦿%{$reset_color%}"

function prompt_online() {
  if [[ -f ~/.offline ]]; then
    echo $OFFLINE
  else
    echo $ONLINE
  fi
}

function ssh_prompt_color() {
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    echo '%{%F{blue}%}'
  else
    echo '%{%F{green}%}'
  fi
}

function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
  vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

# Fix a bug when you C-c in CMD mode and you'd be prompted with CMD mode indicator, while in fact you would be in INS mode
# Fixed by catching SIGINT (C-c), set vim_mode to INS and then repropagate the SIGINT, so if anything else depends on it, we will not break it
function TRAPINT() {
  vim_mode=$vim_ins_mode
  return $(( 128 + $1 ))
}

source ~/zsh-git-prompt/zshrc.sh ;


#PROMPT='%(!.%{$fg[red]%}.%{$fg[green]%})%n$(ssh_prompt_color)@%m%{$reset_color%}: %{$fg[blue]%}%~%{$reset_color%} $(git_super_status) %{$reset_color%} ${vim_mode} %{$fg[white]%}$(background_jobs) %{$reset_color%}'


#
export EDITOR=vim

#To switch between python2.7 and python3
venv() {
    local activate=~/.python/$1/bin/activate
    if [ -e "$activate" ] ; then
        source "$activate"
    else
        echo "Error: Not found: $activate"
    fi
}
venv27() { venv 27 ; }

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down


# Simple alias that creates a markdown file with today's date (might want to look into using a function instead?)
alias daily_post="title=\$(date +%d_%B_%Y).md; vim \$title"

# Codi
# Usage: codi [filetype] [filename]
codi() {
  local syntax="${1:-python}"
  shift
  vim -c \
    "let g:startify_disable_at_vimenter = 1 |\
    set bt=nofile ls=0 noru nonu nornu |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermbg=NONE |\
    hi NonText ctermfg=0 |\
    Codi $syntax" "$@"
}

alias youtube_ringtone="youtube-dl --extract-audio --audio-format mp3 "

#org.eclipse.platform_4.7.0_155965261

alias start_eclimd="nohup /home/mayankbh/.eclipse/org.eclipse.platform_4.7.0_155965261_linux_gtk_x86_64/eclimd 0<&- &>/dev/null &"

synchronized_panes=""

PROMPT='%(!.%{$fg[red]%}.%{$fg[green]%})%n$(ssh_prompt_color)@%m%{$reset_color%}: %{$fg[blue]%}%~%{$reset_color%} $(git_super_status) %{$reset_color%} ${vim_mode} %{$fg[white]%}$(background_jobs) %{$reset_color%} ${synchronized_panes}'

RPROMPT='%{$fg[white]%}%T%{$reset_color%}'

#Update path for LLFI GUI
export PATH="/home/mayankbh/Academics/Fall2017/CS536/Project/NN_Fault_Injection/LLFI_Installer/llfi/bin:$PATH"

export JAVA_HOME="/usr/lib/jvm/java-8-openjdk"

export HADOOP_HOME="/home/mayankbh/Academics/Spring2018/Graph_Scheduling/codebase/Hadoop/hadoop-2.9.0/"
export ZOOKEEPER_HOME="/home/mayankbh/Academics/Spring2018/Graph_Scheduling/codebase/ZooKeeper/zookeeper-3.4.11/"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
