# https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet
# track open time:
alias loadtime="/usr/bin/time zsh -i -c exit"

export ZSH="$HOME/.oh-my-zsh"
export EDITOR='nvim'
export SC='~/sources'

export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

## Machine-specific aliases
for script in ~/profile/zsh/*.sh; do
  . "$script"
done

## Aliases and fuctions
alias vim='NVIM_APPNAME=lazyvim nvim'
alias v=vim
alias vs="vim -c \"lua require('persistence').load({ last = true })\""
alias vp="vim . -c 'Telescope projects'"
alias vr="vim . -c 'Telescope oldfiles'"
alias t=touch
alias z=zsh
alias lg=lazygit
alias python=python3
alias dps="docker ps"
alias aws-sso="aws sso login"
alias aws-whoami="aws sts get-caller-identity"
alias aws-postgres="aws rds generate-db-auth-token --hostname $RDSHOST --port 5432 --region $REGION --username developer"
alias h=history
alias git-whoami="git config user.email"

# secure ssh config
#chmod 600 ~/.ssh/config

# secure pem keys
#chmod 0400

alias config-lazy="cd ~/profile/lazyvim/lua/plugins/ && v ."
alias sc-lazy="cd ~/profile/lazyvim/"
alias sc="cd $SC && ls"

alias config-zsh="v ~/.zshrc"
alias config-aws="v ~/.aws/config"
alias cconfig-mackup="v ~/.mackup.cfg"
alias config-brew="v ~/profile/brew.sh"
alias config-ssh="v ~/.ssh/config"

vdlogs() {
	docker logs $0 >& container_logs
	v container_logs
	rm container_logs
}

## ZSH plugings and configs
source ~/zsh-defer/zsh-defer.plugin.zsh
# eval "$(pyenv virtualenv-init -)" # 20ms to load

# ZSH_THEME="avit"
ZSH_THEME="refined"
# ZSH_THEME="nothing"
DISABLE_MAGIC_FUNCTIONS=true
zstyle ':omz:update' mode auto      # update automatically without asking

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="false"

plugins=(
	# zsh-vi-mode # https://github.com/jeffreytse/zsh-vi-mode
	git
	zsh-syntax-highlighting
	zsh-autosuggestions
	sublime # stt
	aws # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/aws
	aliases # als
	docker # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker
	macos # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/macos
	nvm
	npm # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/npm
	python # py, mkv, vrun
	pip # pipi, https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/pip
	vscode # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vscode
	)
ZVM_VI_ESCAPE_BINDKEY=jk
# zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
zvm_after_init_commands+=('zsh-defer source $HOME/.oh-my-zsh/plugins/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh')

zstyle ':omz:plugins:nvm' lazy yes
export PYTHON_AUTO_VRUN=true

zsh-defer source $ZSH/oh-my-zsh.sh
[ -f ~/.fzf.zsh ] && zsh-defer source ~/.fzf.zsh

# DOCKER
# useful only for Mac OS Silicon M1, M2
docker() {
 if [[ `uname -m` == "arm64" ]] && [[ "$1" == "run" || "$1" == "build" ]]; then
    /usr/local/bin/docker "$1" --platform linux/amd64 "${@:2}"
  else
     /usr/local/bin/docker "$@"
  fi
}

# NVM autocomplete
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && zsh-defer source "$NVM_DIR/nvm.sh"  # Delayed load of nvm
[ -s "$NVM_DIR/bash_completion" ] && zsh-defer source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# azure-cli autocomplete
# test if the file exists and executes
[ -s "$HOMEBREW_PREFIX/etc/bash_completion.d/az" ] && zsh-defer source "$HOMEBREW_PREFIX/etc/bash_completion.d/az"

# SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ] && zsh-defer source "$HOME/.sdkman/bin/sdkman-init.sh"

# Envman: https://github.com/bitrise-io/envman 
[ -s "$HOME/.config/envman/load.sh" ] && zsh-defer source "$HOME/.config/envman/load.sh"
