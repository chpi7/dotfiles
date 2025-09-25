# fzf (https://github.com/scop/bash-completion.git)
eval "$(fzf --bash)"

# bash-completion (https://github.com/junegunn/fzf.git)
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion
