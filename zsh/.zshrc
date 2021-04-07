# vim: ft=conf
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

autoload -Uz compinit promptinit vcs_info
compinit
promptinit

zstyle ':completion:*' menu select
zmodload zsh/complist

# This will set the default prompt to the walters theme
# prompt suse
# PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{240}%1~%f%b %# '
PROMPT='%2~%f%b '

# Path to scripts
export PATH=$PATH:~/scripts

. ~/.zsh_aliases

. /usr/share/fzf/key-bindings.zsh
. /usr/share/fzf/completion.zsh
. /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# use the vi navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# git info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
# PROMPT=\$vcs_info_msg_0_'%# '
zstyle ':vcs_info:git:*' formats '%b'
bindkey '^ ' autosuggest-accept

# ssh
[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)"
