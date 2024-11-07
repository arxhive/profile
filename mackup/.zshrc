#!/usr/bin/env zsh

# https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zmodload zsh/zprof
# Track zsh load time:
alias loadtime="/usr/bin/time zsh -i -c exit"

export SRC="$HOME/src"
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"
export EDITOR='nvim'
export NVIM_APPNAME=lazyvim

export MYBIN="$HOME/bin"
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export GOROOT="$(brew --prefix golang)/libexec"
export SPICETIFYPATH=$HOME/.spicetify
export KREW="${KREW_ROOT:-$HOME/.krew}/bin"
export PATH="$PATH:$MYBIN:$GOBIN:$GOROOT/bin:$SPICETIFYPATH/bin:$KREW"

## Machine-specific aliases
for script in ~/profile/zsh-local/*.zsh; do
  source "$script"
done

## Aliases and fuctions
alias vim="nvim"
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

alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'

alias t=touch
alias z=zsh
alias k=kubecolor
alias ks=k9s
alias ktx=kubectx
kfg() {
  export KUBECONFIG=$@
}
alias lg=lazygit
alias ld=lazydocker

alias tf=terraform
alias tfwl="terraform workspace list"
alias tfwd="terraform workspace select -or-create dev"
alias tfwu="terraform workspace select -or-create uat"
alias tfi="terraform init"
alias tfp="terraform plan -lock=false"
alias tfp-dev="tfwd && tfp -var-file='env/dev.tfvars'"
alias tfp-uat="tfwu && tfp -var-file='env/uat.tfvars'"
alias tfa="terraform apply -auto-approve"
alias tfa-dev="tfwd && terraform apply -auto-approve -var-file='env/dev.tfvars'"
alias tfa-uat="tfwu && terraform apply -auto-approve -var-file='env/uat.tfvars'"

alias python=python3
alias pyvenv=python3 -m venv venv
alias pyactivate="source venv/bin/activate"
alias d=docker
alias dps="docker ps"

alias pass=multipass
pass-root() {
  multipass exec $@ -- sudo bash
}

aws-sso() {
  aws sso login --profile=$@
  export AWS_PROFILE=$@
}
alias aws-whoami="aws sts get-caller-identity | cat"
alias aws-postgres="aws rds generate-db-auth-token --hostname $RDSHOST --port 5432 --region $REGION --username developer"
alias aws-logout="aws sso logout && unset AWS_PROFILE"

alias h=history
alias iexit=exit
alias e=exit
alias q=exit
alias pbpwd='pwd | pbcopy'

alias git-whoami="git config user.email"
alias groot="git ma" # master/main branch
alias gt="git tree"
alias gtt="git full-tree"
alias gsp="git stash-pull"
alias sc-lazy="cd ~/profile/lazyvim/"
alias sc-lazyvim="v $HOME/.local/share/lazyvim/lazy"

alias sc="cd $SRC && cf"
alias uml="cd $HOME/uml/"
alias box="cd $HOME/box/"
alias ext="cd $HOME/ext/"
alias lib="cd $HOME/lib/"
alias logs="cd $HOME/logs/"

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

alias watch='watch '

alias pla="plantuml -gui -theme sketchy -config $HOME/profile/plantuml/sketchy_config&"
plantfile() {
  printf '@startuml\n[A] --> [B]: use\n@enduml' >> $@
}

alias br=w3m
b() {
  w3m 'https://www.google.com/search?q='"$*";
}
bs() {
  w3m 'https://www.google.com/search?q='"$*"' site:https://stackoverflow.com/';
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
  cd $HOME/ext/safaribooks/
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
# binding, ASCII charset:
# https://web.archive.org/web/20091028133103/http://geocities.com/dtmcbride//tech/charsets/ascii.html
bindkey "\x27" autosuggest-accept # ctrl + '

# fzf config and alises
zstyle ':fzf-tab:*' fzf-bindings 'tab:accept'

# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'
export FZF_DEFAULT_OPTS="
  --bind 'ctrl-v:become(nvim {})' \
  --bind 'ctrl-l:become(less +G {})' \
  --bind 'ctrl-p:become(bat {})' \
  --bind 'ctrl-j:become(cat {} | jq)' \
  --bind 'ctrl-o:become(open {})' \
  --bind 'ctrl-b:become(/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome {})' \
  --bind 'ctrl-s:become(/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl {})'
"
export FZF_DEFAULT_COMMAND="
  fd -H -I \
  --type f \
  --exclude .git \
  --exclude node_module \
  --exclude .cache \
  --exclude .npm
"
export FZF_CTRL_T_COMMAND="fd --type f"

alias ff="fzf \
  --preview 'bat --color=always {}' \
  --preview-window border-none,follow \
  --bind 'enter:become(nvim {})' \
  --bind 'ctrl-f:become(echo __dirs__)'"
alias f="ff < <(fd -H -I --exclude .git --exclude node_module --exclude .cache --exclude .npm --type f --max-depth=1)"
# f() {
#   selected="$(ff < <(fd -H -I --exclude .git --exclude node_module --exclude .cache --exclude .npm --type f --max-depth=1))"
#
#   if [[ $? -eq 0 ]]; then
#     if [ "$selected" = "__dirs__" ]; then
#       cf
#     fi
#   fi
# }

alias cff='cd ./"$(fd -H --type d | fzf)"'
cf() {
  selected="$(
  (echo '..'; fd -H --type d --max-depth 1) | fzf \
      --bind 'ctrl-r:become(echo ..)' \
      --preview 'pwd' \
      --preview-window 1,top,border-none \
      --bind 'ctrl-f:become(echo __files__)'
  )"

  # Check the exit code of fzf
  if [[ $? -eq 0 ]]; then
    if [ "$selected" = "__files__" ]; then
      f
    else
      cd $selected
      cf
    fi
  fi
}

alias fps="ps -ef |
  fzf --bind 'ctrl-r:reload(ps -ef)' \
      --header 'Press CTRL-R to reload' --header-lines=1 \
      --height=100% --layout=reverse"

alias fpkill="ps -e | fzf | awk '{print $1}' | xargs kill"

fzf-git-branch() {
    git rev-parse HEAD > /dev/null 2>&1 || return

    git branch --color=always --all --sort=-committerdate |
        grep -v HEAD |
        fzf --height 50% --ansi --no-multi --preview-window right:65% \
            # --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed "s/.* //" <<< {})' |
        sed "s/.* //"
}

fzf-git-checkout() {
    git rev-parse HEAD > /dev/null 2>&1 || return

    local branch

    branch=$(fzf-git-branch)
    if [[ "$branch" = "" ]]; then
        echo "No branch selected."
        return
    fi

    # If branch name starts with 'remotes/' then it is a remote branch. By
    # using --track and a remote branch name, it is the same as:
    # git checkout -b branchName --track origin/branchName
    if [[ "$branch" = 'remotes/'* ]]; then
        git checkout --track $branch
    else
        git checkout $branch;
    fi
}


# Script to open the GitHub page of the current repository in a browser
gh() {
  fetch_url=$(git config --get remote.origin.url)
  # outputs:
  # git@github.com:some-name/some-repo-name.git
  # https://github.com/some-name/some-repo-name.git
  # ssh://arxhive/arxhive/profile.git


  if [[ $fetch_url == *"https"* ]]; then
      # Remove the .git from the end of the URL
      github_url="${fetch_url%.git}"
  elif [[ "$fetch_url" == *"ssh://"* ]]; then
      # Remove the 'ssh://' prefix
      url_without_prefix="${fetch_url#ssh://}"

      # Extract the part after the first '/'
      extracted_part="${url_without_prefix#*/}"

      # Remove the .git from the end of the URL
      url_portion="${extracted_part%.git}"

      # Construct the final GitHub URL
      github_url="https://github.com/"$url_portion
  else
      # Split the URL on ':' and get the 2nd portion
      url_portion="$(echo "$fetch_url" | awk -F':' '{print $2}')"

      # Remove the .git from the end of the URL
      url_portion="${url_portion%.git}"

      # Construct the final GitHub URL
      github_url="https://github.com/"$url_portion
  fi

  chrome "$github_url"
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
	zsh-vi-mode # https://github.com/jeffreytse/zsh-vi-mode
  zsh-system-clipboard
	git # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
  # fzf-zsh-plugin # https://github.com/unixorn/fzf-zsh-plugin
	zsh-syntax-highlighting
	zsh-autosuggestions
  zsh-fzf-history-search # ^R
	sublime # stt
	aws # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/aws
	aliases # als
	docker # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker
	macos # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/macos
  zsh-nvm # lazy load and autocomplete
	npm # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/npm
	python # py, mkv, vrun
	pip # pipi, https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/pip
	# vscode # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vscode
  fzf-tab
	)

function zvm_config() {
  ZVM_KEYTIMEOUT=0.03
  ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLOCK
  ZVM_VI_HIGHLIGHT_BACKGROUND=black
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
}

# zsh-vi-mode plugin will overwrite the previous key bindings, this causes the key bindings of other plugins to fail (fzf, zsh-autocomplete, zsh-iteractive-cd).
# the plugin will auto execute this zvm_after_init function to solve this issue
function zvm_after_init() {
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
  source "$ZSH/plugins/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh"

  # provides smother user experinace, less flickering
  unset ZSH_AUTOSUGGEST_USE_ASYNC
}

# zsh-system-clipboard config
# ZSH_SYSTEM_CLIPBOARD_METHOD='pb'
bindkey -M vicmd Y zsh-system-clipboard-vicmd-vi-yank-eol
bindkey -M vicmd y zsh-system-clipboard-vicmd-vi-yank # does not work as expected?

export PYTHON_AUTO_VRUN=false
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true
export NVM_DIR="$HOME/.nvm"

source "$ZSH/oh-my-zsh.sh"

# Aliases to ovewrite zsh alias plugin
alias l="gls -1 -a --color --group-directories-first"
alias ll="gls -a --color --group-directories-first"
alias ls="gls -1 -al --color --group-directories-first"
alias gb='fzf-git-branch'
alias gco='fzf-git-checkout'

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
# make completion work with kubecolor
compdef kubecolor=kubectl

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# FAQ:
# A; B    # Run A and then B, regardless of success of A
# A && B  # Run B if and only if A succeeded
# A || B  # Run B if and only if A failed
# A &     # Run A in background.

# zprof
