#!/usr/bin/env zsh

# https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zmodload zsh/zprof
# Track zsh load time:
alias loadtime="/usr/bin/time zsh -i -c exit"

export ZSH="$HOME/.oh-my-zsh"
export EDITOR='nvim'
export NVIM_APPNAME=lazyvim
export SC="$HOME/sources"

export GOPATH=$HOME/go
export GOBIN=${GOPATH}/bin
export GOROOT="$(brew --prefix golang)/libexec"
export SPICETIFYPATH=$HOME/.spicetify
export KREW="${KREW_ROOT:-$HOME/.krew}/bin"
export PATH="$PATH:${GOBIN}:${GOROOT}/bin:${SPICETIFYPATH}/bin:${KREW}"

## Machine-specific aliases
for script in ~/profile/zsh-local/*.zsh; do
  source "$script"
done
## Aliases and fuctions
alias vim='nvim'
alias v=vim
alias vs="vim -c \"lua require('persistence').load({ last = true })\""
alias vr="vim . -c 'Telescope oldfiles'"
alias vv="vim . -c 'Kindle'"
alias vm="vim . -c 'DiffviewOpen'"
alias vf='vim $(fzf)'
alias vvs="vim . -c 'KindleLastSession'"

alias x=tmux
alias xn="tmux new -s"
alias xls="tmux ls"
alias xa="tmux a"
alias xat="tmux a -t"
alias xnuke="tmux kill-server"
alias xk="tmux kill-session"
alias xkt="tmux kill-session -t"

alias t=touch
alias z=zsh
alias k=kubecolor
alias ks=k9s
alias ktx=kubectx
alias lg=lazygit
alias ld=lazydocker
alias e="exit"
alias tf=terraform
alias tfi=terraform init
alias tfp=terraform plan
alias tfa=terraform apply

alias python=python3
alias pyvenv=python3 -m venv venv
alias pyactivate="source venv/bin/activate"
alias dps="docker ps"

aws-sso() {
  aws sso login --profile=$@
  export AWS_PROFILE=$@
}
alias aws-whoami="aws sts get-caller-identity"
alias aws-postgres="aws rds generate-db-auth-token --hostname $RDSHOST --port 5432 --region $REGION --username developer"
alias aws-logout="aws sso logout && unset AWS_PROFILE"

alias h=history
alias iexit=exit
alias e=exit
alias q=exit
alias cf='cd ./"$(fd --type d | fzf)"'
alias pbpwd='pwd | pbcopy'

alias git-whoami="git config user.email"
alias groot="git ma" # master/main branch
alias gt="git tree"
alias gtt="git full-tree"
alias gsp="git stash-pull"
alias sc-lazy="cd ~/profile/lazyvim/"
alias sc-nvim-lazy="v $HOME/.local/share/lazyvim/lazy"
alias sc="cd $SC && ls"

alias weight="du -hsx 2>/dev/null * | sort -hr | less"
alias curweight="du -hs"

alias mmlazy="cd ~/profile/lazyvim/lua/ && v ."
alias mmbrew="v ~/profile/brew.sh"
alias mmzsh="v ~/.zshrc"
alias mmmackup="v ~/.mackup.cfg"
alias mmaws="v ~/.aws/config"
alias mmssh="v ~/.ssh/config"
alias mmgit="v ~/.config/git/config"
alias mmtmux="v ~/.tmux.conf"
alias mmskhd="v ~/.skhdrc"
alias mmnvim="v ~/.local/share/lazyvim/lazy/LazyVim/lua/lazyvim"
alias mmplant="v ~/profile/plantuml/sketchy_config"

alias pla="plantuml -gui -theme sketchy -config $HOME/profile/plantuml/sketchy_config&"
plantfile() {
  printf '@startuml\n[A] --> [B]: use\n@enduml' >> $@
}
alias br=w3m
b() {
  w3m 'https://www.google.com/search?q='"$*";
}

alias nomoregopls="ps -ef | grep 'gopls' | grep -v grep | awk '{print $2}' | xargs -r kill -9"

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

chmod-pub() {
  chmod 600 $@ # or 644 to make them readable for all
}

chmod-ssh-dir() {
  chmod 700 $@
}

ports() {
  lsof -i :$@
}

lports() {
  sudo lsof -i -P | grep LISTEN | grep :$@
}

grepy() {
  grep -HIFrni --color=always $@ .
}

safari() {
  cd $HOME/bin/safaribooks/
  pyactivate
  python3 safaribooks.py --kindle $@
  cd Books/*$@*
  ls

  echo "Pass to send it to Kindle or cancel:"
  read pass # TODO: find a way how to hide input

  to=$(echo $KINDLE_EMAIL | openssl aes-256-cbc -pbkdf2 -d -a -salt -pass pass:$pass)
  from=$(echo $GMAIL_EMAIL | openssl aes-256-cbc -pbkdf2 -d -a -salt -pass pass:$pass)
  code=$(echo $SWAKS_GMAIL_CODE | openssl aes-256-cbc -pbkdf2 -d -a -salt -pass pass:$pass)

  # zip $@.zip $@.epub
  title=$(pwd | sed -E 's|.*/Books/(.*) \([0-9]+\)|\1|')
  title=$title.epub
  cp $@.epub $title

  swaks --body $@ --header "Subject: "$@ --to $to -attach @$title -s smtp.gmail.com:587 -tls --auth-user $from --auth-password $code --auth-hide-password
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
	git # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
	zsh-syntax-highlighting
	zsh-autosuggestions
  zsh-fzf-history-search
	sublime # stt
	aws # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/aws
	aliases # als
	docker # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker
  # kubectl
  # Kube-ps1
	macos # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/macos
  zsh-nvm # lazy load and autocomplete
	npm # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/npm
	python # py, mkv, vrun
	pip # pipi, https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/pip
	# vscode # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vscode
	)
# ZVM_VI_ESCAPE_BINDKEY=jk

export PYTHON_AUTO_VRUN=false
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true
export NVM_DIR="$HOME/.nvm"

source "$ZSH/oh-my-zsh.sh"
source "$HOME/.oh-my-zsh/plugins/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Docker backward compatibility for Mac M1
docker() {
  if [[ $(uname -m) == "arm64" ]] && [[ "$1" == "run" || "$1" == "build" ]]; then
    /usr/local/bin/docker "$1" --platform linux/amd64 "${@:2}"
  else
     /usr/local/bin/docker "$@"
  fi
}

# azure-cli autocomplete
# test if the file exists and executes
[ -s "$HOMEBREW_PREFIX/etc/bash_completion.d/az" ] && source "$HOMEBREW_PREFIX/etc/bash_completion.d/az"

# SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Envman: https://github.com/bitrise-io/envman 
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# kubectl
[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zprof
