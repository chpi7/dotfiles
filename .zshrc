export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="half-life"

plugins=(
	git
	fzf
)

source $ZSH/oh-my-zsh.sh

# λ
PROMPT="${purple}%➜%{$reset_color%} in ${limegreen}%~%{$reset_color%}\$(ruby_prompt_info)\$vcs_info_msg_0_${orange} λ%{$reset_color%} "
# PROMPT="%{$fg_bold[red]%}➜ %{$fg_bold[green]%} %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}"
