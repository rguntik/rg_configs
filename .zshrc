export ZSH="/home/dart/.oh-my-zsh"
export TERM="xterm-256color"

if [ -z "$TMUX" ]; then
   ZSH_THEME="amuse"
else
   ZSH_THEME="powerlevel9k/powerlevel9k"
   POWERLEVEL9K_MODE='awesome-fontconfig'

   POWERLEVEL9K_PROMPT_ON_NEWLINE=true
   POWERLEVEL9K_RPROMPT_ON_NEWLINE=true

   POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=( vi_mode os_icon dir vcs )

   POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=( status root_indicator background_jobs history ram )
   POWERLEVEL9K_VI_INSERT_MODE_STRING="I"
   POWERLEVEL9K_VI_COMMAND_MODE_STRING="N"
fi

plugins=(vi-mode git symfony-console docker docker-compose fzf-zsh zsh-autosuggestions zsh-syntax-highlighting common-aliases colored-man-pages)

source $ZSH/oh-my-zsh.sh

bindkey "e[1~" beginning-of-line
bindkey "e[4~" end-of-line
bindkey "^@" vi-forward-char

alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias toolbox="~/workspace/oht/toolbox.sh"
alias c="| xclip -sel clip"
alias pi="~/./workspace/pi/run.sh"
alias listendump="toolbox exec php /ohtmain/oht/oht.php /ohtmain/oht/RGCli/listendump/listendump.php"
alias localPatch="~/./workspace/oht/RGCli/patch/localPatch.sh"

########################################################################
_symfonyContainerCompdefGetRaw() {
    eval "$1 --raw" | sed 's/:/\\:/g' | sed 's/ \{2,\}/:/g'
}
_symfonyContainerCompdef() {
    local suggestions

    suggestions=("${(@f)$(_symfonyContainerCompdefGetRaw $1)}")
    _describe -t commands "command subcommand" suggestions
}

authPhpSsh="docker exec authentication_php php bin/console"
authPhpSshTi="docker exec -ti authentication_php php bin/console"
alias lego_auth_console=$authPhpSshTi

compdef '_symfonyContainerCompdef $authPhpSsh' lego_auth_console

# autocompleate for aliases
setopt complete_aliases
fpath=(~/rg_configs $fpath)
autoload -U compinit
compinit

########################################################################
