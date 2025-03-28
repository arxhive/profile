#!/usr/bin/env zsh

# https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

setopt HIST_IGNORE_SPACE
HISTORY_IGNORE="z|h|q|clear"

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
export SCALABIN="$(brew --prefix scala)@2.13/bin"
export JAVA_HOME=$(/usr/libexec/java_home)

export PATH="$PATH:$MYBIN:$GOBIN:$GOROOT/bin:$SPICETIFYPATH/bin:$KREW:$SCALABIN:$JAVA_HOME/bin"

## my spells
for script in ~/profile/zsh/*.zsh; do
  source "$script"
done

## Machine-specific aliases
for script in ~/profile/zsh-local/*.zsh; do
  source "$script"
done

# binding, ASCII charset:
# https://web.archive.org/web/20091028133103/http://geocities.com/dtmcbride//tech/charsets/ascii.html
bindkey "\x27" autosuggest-accept # ctrl + '

## ZSH plugings and configs

# map python to pyenv shims: /.pyenv/shims/python3
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# automatically activate virtualenvs
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
