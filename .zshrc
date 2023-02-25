# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="ys"
ZSH_THEME="candy"

plugins=(
    sudo
    z
    safe-paste
    extract
    history-substring-search
    colored-man-pages
    git
    history
    tmux
	#vi-mode
	zsh-vi-mode

    # 第三方插件
    zsh-autosuggestions
    zsh-syntax-highlighting
    pyenv-lazy
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Bind key
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down


# 语言配置
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"


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

# autocompletion
# if [ -f $(brew --prefix)/etc/bash_completion ]; then
# . $(brew --prefix)/etc/bash_completion
# fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
source /Users/lifeibo/work/bin/l source
