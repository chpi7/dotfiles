# fzf (https://github.com/scop/bash-completion.git)
eval "$(fzf --bash)"

HISTSIZE=-1
HISTFILESIZE=-1

# bash-completion (https://github.com/junegunn/fzf.git)
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND" 
