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

alias fkill="ps -e | fzf | awk '{print $1}' | xargs kill"

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

