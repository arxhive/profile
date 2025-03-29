# fzf config and alises
zstyle ':fzf-tab:*' fzf-bindings 'tab:accept'

# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'
export FZF_DEFAULT_OPTS="
  --bind 'ctrl-v:become(nvim {})' \
  --bind 'ctrl-l:become(less +G {})' \
  --bind 'ctrl-p:become(bat {})' \
  --bind 'ctrl-j:become(cat {} | jq)' \
  --bind 'ctrl-t:become(tail -f {})' \
  --bind 'ctrl-o:become(open {})' \
  --bind 'ctrl-h:become(realpath {})' \
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

alias files-fzf="fzf \
    --header $'CTRL-D Dirs, CRTL-K Keys' \
    --preview 'bat --color=always {}' \
    --preview-window border-none,follow \
    --bind 'enter:become(echo __nvim__:{})' \
    --bind 'ctrl-v:become(echo __nvim__:{})' \
    --bind 'ctrl-l:become(echo __less__:{})' \
    --bind 'ctrl-p:become(echo __bat__:{})' \
    --bind 'ctrl-j:become(echo __cat__:{})' \
    --bind 'ctrl-t:become(echo __tail__:{})' \
    --bind 'ctrl-o:become(echo __finder__:{})' \
    --bind 'ctrl-b:become(echo __chrome__:{})' \
    --bind 'ctrl-s:become(echo __sublime__:{})' \
    --bind 'ctrl-h:become(echo __path__:{})' \
    --bind 'ctrl-k:become(echo __help__:{})' \
    --bind 'ctrl-d:become(echo __dirs__)'"

ff() {
  selected="$(files-fzf)"

  if [[ $? -eq 0 ]]; then
    if [ "$selected" = "__dirs__" ]; then
      cff
    elif [[ "$selected" == __nvim__:* ]]; then
      nvim "${selected#__nvim__:}"
    elif [[ "$selected" == __less__:* ]]; then
      less "${selected#__less__:}"
    elif [[ "$selected" == __bat__:* ]]; then
      bat "${selected#__bat__:}"
    elif [[ "$selected" == __cat__:* ]]; then
      cat "${selected#__cat__:}" | jq
    elif [[ "$selected" == __tail__:* ]]; then
      tail -f "${selected#__tail__:}"
    elif [[ "$selected" == __finder__:* ]]; then
      open "${selected#__finder__:}"
    elif [[ "$selected" == __chrome__:* ]]; then
      /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome "${selected#__chrome__:}"
    elif [[ "$selected" == __sublime__:* ]]; then
      /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl "${selected#__sublime__:}"
    elif [[ "$selected" == __path__:* ]]; then
      realpath "${selected#__path__:}"
    elif [[ "$selected" == __help__:* ]]; then
      echo "CTRL-D: Dirs"
      echo "CTRL-K: Keys"
      echo "CTRL-V: Open in nvim"
      echo "CTRL-L: Open in less"
      echo "CTRL-P: Print in bat"
      echo "CTRL-J: Cat json"
      echo "CTRL-T: Tail logs"
      echo "CTRL-O: Open in finder"
      echo "CTRL-B: Open in Chrome"
      echo "CTRL-S: Open in Sublime Text"
      echo "CTRL-H: Print realpath"
    fi
  fi
}

f() {
  selected="$(files-fzf < <(fd -H -I --exclude .git --exclude node_module --exclude .cache --exclude .npm --type f --max-depth=1))"

  if [[ $? -eq 0 ]]; then
    if [ "$selected" = "__dirs__" ]; then
      cf
    elif [[ "$selected" == __nvim__:* ]]; then
      nvim "${selected#__nvim__:}"
    elif [[ "$selected" == __less__:* ]]; then
      less "${selected#__less__:}"
    elif [[ "$selected" == __bat__:* ]]; then
      bat "${selected#__bat__:}"
    elif [[ "$selected" == __cat__:* ]]; then
      cat "${selected#__cat__:}" | jq
    elif [[ "$selected" == __tail__:* ]]; then
      tail -f "${selected#__tail__:}"
    elif [[ "$selected" == __finder__:* ]]; then
      open "${selected#__finder__:}"
    elif [[ "$selected" == __chrome__:* ]]; then
      /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome "${selected#__chrome__:}"
    elif [[ "$selected" == __sublime__:* ]]; then
      /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl "${selected#__sublime__:}"
    elif [[ "$selected" == __path__:* ]]; then
      realpath "${selected#__path__:}"
    elif [[ "$selected" == __help__:* ]]; then
      echo "CTRL-D: Dirs"
      echo "CTRL-K: Keys"
      echo "CTRL-V: Open in nvim"
      echo "CTRL-L: Open in less"
      echo "CTRL-P: Print in bat"
      echo "CTRL-J: Cat json"
      echo "CTRL-T: Tail logs"
      echo "CTRL-O: Open in finder"
      echo "CTRL-B: Open in Chrome"
      echo "CTRL-S: Open in Sublime Text"
      echo "CTRL-H: Print realpath"
    fi
  fi
}

cff() {
  cd ./"$(fd -H --type d | fzf)"
}

cf() {
  selected="$(
    (
      echo '..'
      fd -H --type d --max-depth 1
    ) | fzf \
      --header $'CTRL-F Files, CRTL-K Keys' \
      --bind 'ctrl-r:become(echo ..)' \
      --preview 'pwd' \
      --preview-window 1,top,border-none \
      --bind 'ctrl-f:become(echo __files__)' \
      --bind 'ctrl-v:become(echo __nvim__)' \
      --bind 'ctrl-k:become(echo __help__:{})' \
      --bind 'ctrl-o:become(echo __open__)'
  )"

  # Check the exit code of fzf
  if [[ $? -eq 0 ]]; then
    if [ "$selected" = "__files__" ]; then
      f
    elif [ "$selected" = "__nvim__" ]; then
      nvim .
    elif [ "$selected" = "__open__" ]; then
      open .
    elif [[ "$selected" == __help__:* ]]; then
      echo "CTRL-D: Dirs"
      echo "CTRL-K: Keys"
      echo "CTRL-V: Open current dir in nvim"
      echo "CTRL-O: Open in finder"
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
  git rev-parse HEAD >/dev/null 2>&1 || return

  git branch --color=always --all --sort=-committerdate |
    grep -v HEAD |
    fzf --height 50% --ansi --no-multi --preview-window right:65%
  # --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed "s/.* //" <<< {})' |
  sed "s/.* //"
}

fzf-git-checkout() {
  git rev-parse HEAD >/dev/null 2>&1 || return

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
    git checkout $branch
  fi
}
