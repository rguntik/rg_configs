# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="/home/roma/.oh-my-zsh"
export TERM="xterm-256color"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(vi-mode git symfony-console docker docker-compose fzf-zsh zsh-autosuggestions zsh-syntax-highlighting common-aliases colored-man-pages zsh-oht-toolbox)

source $ZSH/oh-my-zsh.sh

bindkey "e[1~" beginning-of-line
bindkey "e[4~" end-of-line
bindkey "^@" vi-forward-char

alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias rgtm="~/./rg_configs/tmux.sh"
alias c="| xclip -sel clip"
alias pi="~/./workspace/pi/run.sh"
alias listendump="toolbox exec php /ohtmain/oht/oht.php /ohtmain/oht/RGCli/listendump/listendump.php"
alias localPatch="~/./workspace/oht/RGCli/patch/localPatch.sh"

alias clast="~/./workspace/mnemo_php/getLast.sh c"
alias vlast="~/./workspace/mnemo_php/getLast.sh v"
alias llast="~/./workspace/mnemo_php/getLast.sh l"
alias ml="~/./workspace/mnemo_php/getLast.sh color"

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

autoload -U compinit
compinit

########################################################################

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
