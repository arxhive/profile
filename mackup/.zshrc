# https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet

export ZSH="$HOME/.oh-my-zsh"
export EDITOR='nvim'
export SC='~/sources'

#Company specific aliases
for script in ~/profile/zsh/*.sh; do
  . "$script"
done

alias t=touch
alias dps="docker ps"
alias aws-sso="aws sso login"
alias aws-whoami="aws sts get-caller-identity"
alias aws-postgres="aws rds generate-db-auth-token --hostname $RDSHOST --port 5432 --region $REGION --username developer"
alias h=history
alias vim=nvim
alias v='NVIM_APPNAME=nvim-lazyvim nvim' # LazyVim
# alias vc='NVIM_APPNAME=nvim-nvchad nvim' # NvChad
# alias vk='NVIM_APPNAME=nvim-kickstart nvim' # Kickstart

# secure ssh config
#chmod 600 ~/.ssh/config

# secure pem keys
#chmod 0400

alias lua="v ~/profile/nvim-lazyvim/lua/plugins/"
alias sc-lua="cd ~/profile/nvim-lazyvim/"
alias sc="cd $SC && ls"

alias cfg_zsh="st ~/.zshrc"
alias cfg_aws="st ~/.aws/config"
alias cfg_mackup="st ~/.mackup.cfg"

# vv() {
#   select config in lazyvim kickstart nvchad astrovim lunarvim
#   do NVIM_APPNAME=nvim-$config nvim $@; break; done
# }

eval "$(pyenv virtualenv-init -)"

# ZSH_THEME="avit"
ZSH_THEME="refined"
# ZSH_THEME="nothing"
DISABLE_MAGIC_FUNCTIONS=true
zstyle ':omz:update' mode auto      # update automatically without asking

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="falsest"

plugins=(
	zsh-vi-mode # https://github.com/jeffreytse/zsh-vi-mode
	git
	zsh-syntax-highlighting
	zsh-autosuggestions
	sublime # stt
	vscode # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vscode
	aws # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/aws
	aliases # als
	docker # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker
	macos # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/macos
	nvm
	npm # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/npm
	python # py, mkv, vrun
	pip # pipi, https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/pip
	)
ZVM_VI_ESCAPE_BINDKEY=jk
# zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
zvm_after_init_commands+=('source $HOME/.oh-my-zsh/plugins/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh')

zstyle ':omz:plugins:nvm' lazy yes
export PYTHON_AUTO_VRUN=true

source $ZSH/oh-my-zsh.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#source $HOME/.oh-my-zsh/plugins/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh

#NVM
    export NVM_DIR="$HOME/.nvm"
    [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
    [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# DOCKER
# useful only for Mac OS Silicon M1, M2
# docker() {
#  if [[ `uname -m` == "arm64" ]] && [[ "$1" == "run" || "$1" == "build" ]]; then
#     /usr/local/bin/docker "$1" --platform linux/amd64 "${@:2}"
#   else
#      /usr/local/bin/docker "$@"
#   fi
# }

#SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
