setopt share_history
unsetopt inc_append_history_time
unsetopt inc_append_history
setopt hist_expire_dups_first

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^H' backward-kill-word

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# Prompt
PROMPT='%(?.%F{blue}.%F{red})%f %2~ > '

alias gd='git diff'
alias gds='git diff --staged'
alias gc='git commit'
alias gc='git commit'
alias gst='git status'
alias gco='git checkout'

function add_to_path {
	export PATH=$1:$PATH
}

function setup_fzf {
	# fzf (https://github.com/junegunn/fzf.git)
	if fzf --zsh &>/dev/null; then
		source <(fzf --zsh)
	else
		source /usr/share/doc/fzf/examples/key-bindings.zsh
	fi
}

add_to_path $HOME/.local/bin
add_to_path $HOME/.cargo/bin

setup_fzf

if [ -d $HOME/repos/neovim/build_install/bin ]; then
    add_to_path $HOME/repos/neovim/build_install/bin
fi
