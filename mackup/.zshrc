# https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Track zah load time:
alias loadtime="/usr/bin/time zsh -i -c exit"

export ZSH="$HOME/.oh-my-zsh"
export EDITOR='nvim'
export SC='~/sources'

export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

## Machine-specific aliases
for script in ~/profile/zsh-local/*.zsh; do
  source "$script"
done

## Aliases and fuctions
alias vim='NVIM_APPNAME=lazyvim nvim'
alias v=vim
alias vs="vim -c \"lua require('persistence').load({ last = true })\""
alias vp="vim . -c 'Telescope projects'"
alias vr="vim . -c 'Telescope oldfiles'"
alias vv="vim . -c 'Kindle'"
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

alias sc-lazy="cd ~/profile/lazyvim/"
alias sc="cd $SC && ls"

alias conf-lazy="cd ~/profile/lazyvim/lua/plugins/ && v ."
alias conf-zsh="v ~/.zshrc"
alias conf-aws="v ~/.aws/config"
alias conf-mackup="v ~/.mackup.cfg"
alias conf-brew="v ~/profile/brew.sh"
alias conf-ssh="v ~/.ssh/config"

vdlogs() {
	docker logs $@ >& container_logs
	v container_logs
	rm container_logs
}

chmod-sh() {
  chmod 744 $@
}

chmod-pem() {
  chmod 0400 $@
}

chmod-ssh() {
  chmod 600 $@
}

## ZSH plugings and configs
# eval "$(pyenv virtualenv-init -)" # 20ms to load

ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="avit"
# ZSH_THEME="refined"
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
# ZVM_VI_ESCAPE_BINDKEY=jk

zstyle ':omz:plugins:nvm' lazy yes
export PYTHON_AUTO_VRUN=false

source $ZSH/oh-my-zsh.sh
source $HOME/.oh-my-zsh/plugins/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Docker backward compatibility for Mac M1
docker() {
 if [[ `uname -m` == "arm64" ]] && [[ "$1" == "run" || "$1" == "build" ]]; then
    /usr/local/bin/docker "$1" --platform linux/amd64 "${@:2}"
  else
     /usr/local/bin/docker "$@"
  fi
}

# NVM autocomplete
export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # Don't need to source this because it's already sourced by brew
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# azure-cli autocomplete
# test if the file exists and executes
[ -s "$HOMEBREW_PREFIX/etc/bash_completion.d/az" ] && source "$HOMEBREW_PREFIX/etc/bash_completion.d/az"

# SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Envman: https://github.com/bitrise-io/envman 
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
