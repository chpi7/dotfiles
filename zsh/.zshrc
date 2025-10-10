setopt share_history

HISTFILE=~/.zsh_history
HISTIZE=1000000
SAVEHIST=1000000

# fzf (https://github.com/junegunn/fzf.git)
eval "$(fzf --zsh)"

# Prompt
PROMPT='%(?.%F{blue}⏺.%F{red}⏺)%f %2~ > '
