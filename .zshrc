# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export TERM="xterm-256color"

# Some vars
export HOMEBREW_NO_AUTO_UPDATE="1"

# Options
# dont work with zsh-autosuggestions
setopt noautomenu
setopt nomenucomplete

# General
DISABLE_AUTO_TITLE="false"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
SAVEHIST=99999

bindkey ';e' autosuggest-execute
bindkey '; ' autosuggest-accept

# vi-mode
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true
MODE_INDICATOR="%F{white}+%f"
INSERT_MODE_INDICATOR="%F{yellow}+%f"

plugins=(
    git
    alias-tips
    vi-mode
    helm
    kubectl
    docker
    docker-compose
    zsh-autosuggestions
)

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
alias vimrc="vim ~/.vimrc"
alias zshrc="vim ~/.zshrc"

# Job specific
if [[ "$OSTYPE" == "darwin"* ]]; then
  alias ctags="`brew --prefix`/bin/ctags"
  alias ctags >> ~/.bash_profile
fi

# Commands
export GREP_COLOR="1;32"
export ZSH_PLUGINS_ALIAS_TIPS_TEXT="Alias: "

#Functions
mkcd ()
{
    mkdir -p -- "$1" &&
    cd -P -- "$1"
}

[[ ! -f ~/.Xmodmap ]] || xmodmap ~/.Xmodmap

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if ! [ -z $ST_PATH ]; then
    cd "$ST_PATH"
fi

if ! [ -z $ST_COM ]; then
    bash -c "$ST_COM"
fi

if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "/opt/nvim-linux-x86_64/bin" ]; then
    export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
fi

if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi
