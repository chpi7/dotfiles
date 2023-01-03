export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="half-life"

plugins=(
	git
	fzf
)

source $ZSH/oh-my-zsh.sh

# λ
PROMPT='➜  %{$fg[cyan]%}%c$vcs_info_msg_0_ %{$reset_color%}'
