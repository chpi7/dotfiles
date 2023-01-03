export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="half-life"

plugins=(
	git
	fzf
)

source $ZSH/oh-my-zsh.sh

# λ
PROMPT="${red}%➜%{$reset_color%} %c $vcs_info_msg_0_${orange} %{$reset_color%} "
# PROMPT="%{$fg_bold[red]%}➜ %{$fg_bold[green]%} %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}"
