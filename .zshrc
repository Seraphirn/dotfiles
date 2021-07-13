# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export TERM="xterm-256color"

# Options
setopt hist_ignore_dups
setopt hist_expire_dups_first

# General
DISABLE_AUTO_TITLE="false"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
SAVEHIST=99999

# Magic Enter
MAGIC_ENTER_GIT_COMMAND="git status -v && exag && echo -e '\n'"
MAGIC_ENTER_OTHER_COMMAND="ls && echo -e '\n'"

plugins=(git
         alias-tips
         extract
         sudo
         fzf
         vi-mode
         magic-enter
         fast-syntax-highlighting
         zsh-autosuggestions
         web-search)


# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Powerlevel9k
POWERLEVEL9K_MODE="nerdfont-complete"

source $ZSH/oh-my-zsh.sh

# Aliases
alias vim="nvim"
alias ccp="clipcopy"
alias cp="cp -irv"
alias cpa="clippaste"
alias diff="diff --color=auto"
alias exag="exa -ahlT -L=1  -s=extension --git --group-directories-first"
alias fdir='find . -type d -name'
alias ffil='find . -type f -name'
alias grep="grep --color=auto"
alias jupn="jupyter notebook"
alias la="ls -AXb --group-directories-first --sort=extension"
alias ln="ln -sv"
alias lsda="lsd -A --group-dirs first --classify"
alias lsdo="lsd -A --group-dirs first --classify --recursive --depth=2"
alias mv="mv -iv"
alias ncdu="ncdu --color=dark -x"
alias pp="prettyping --nolegend"
alias q="exit"
alias rm="rm -irv"
alias sysd="sudo systemctl disable"
alias syse="sudo systemctl enable"
alias sysr="sudo systemctl restart"
alias syss="systemctl status"
alias systa="sudo systemctl start"
alias systo="sudo systemctl stop"
alias vimrc="vim ~/.vimrc"
alias yayi="yay -S"
alias yayu="yay -Syu"
alias zshrc="vim ~/.zshrc"

alias ggl="google"
alias ya="yandex"


# Commands
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_BASE='~/.fzf'
export GREP_COLOR="1;32"
export ZSH_PLUGINS_ALIAS_TIPS_TEXT="Alias: "

#Functions
function lc () {
    cd $1 &&
    la $2
}

mkcd ()
{
    mkdir -p -- "$1" &&
    cd -P -- "$1"
}

[[ ! -f ~/.Xmodmap ]] || xmodmap ~/.Xmodmap

# enter command ls on changing dir
#chpwd() ls

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if ! [ -z $ST_PATH ]; then
    cd "$ST_PATH"
fi

if ! [ -z $ST_COM ]; then
    bash -c "$ST_COM"
fi

setopt noautomenu
setopt nomenucomplete
