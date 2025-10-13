setopt share_history
unsetopt inc_append_history_time
unsetopt inc_append_history
setopt hist_expire_dups_first

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# Prompt
PROMPT='%(?.%F{blue}o.%F{red}o)%f %2~ > '

alias gd='git diff'
alias gds='git diff --staged'
alias gc='git commit'
alias gc='git commit'
alias gst='git status'
alias gco='git checkout'


export PATH=/home/user/.local/bin:$PATH

if [ -d /home/user/repos/neovim/build_install/bin ]; then
    export PATH=/home/user/repos/neovim/build_install/bin:$PATH
fi


# fzf (https://github.com/junegunn/fzf.git)
source <(fzf --zsh)
