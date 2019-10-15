# source ~/.fonts/*.sh

export ZSH="/home/dart/.oh-my-zsh"
export TERM="xterm-256color"

if [ -z "$TMUX" ]; then
   ZSH_THEME="amuse"
else
# sudo apt-get install fonts-powerline
   ZSH_THEME="powerlevel9k/powerlevel9k"
   POWERLEVEL9K_MODE='awesome-fontconfig'

   POWERLEVEL9K_PROMPT_ON_NEWLINE=true
   POWERLEVEL9K_RPROMPT_ON_NEWLINE=true

   POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=( os_icon dir vcs )

   POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=( status root_indicator background_jobs history ram )
fi

plugins=(git)

fpath=(~/rg_configs $fpath)

source $ZSH/oh-my-zsh.sh

alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias toolbox="~/workspace/oht/toolbox.sh"
alias c="xclip -sel clip"
alias pi="~/./workspace/pi/pi"

fpath=(~/rg_configs $fpath)
autoload -U compinit
compinit
