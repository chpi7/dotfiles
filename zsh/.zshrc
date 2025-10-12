setopt share_history
unsetopt inc_append_history_time
unsetopt inc_append_history
setopt hist_expire_dups_first

HISTFILE=~/.zsh_history
HISTIZE=1000000
SAVEHIST=1000000

# Prompt
PROMPT='%(?.%F{blue}⏺.%F{red}⏺)%f %2~ > '

# fzf (https://github.com/junegunn/fzf.git)
eval "$(fzf --zsh)"
