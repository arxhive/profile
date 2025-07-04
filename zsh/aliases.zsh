
# Regular Colors
# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White
Clear='\033[0m'           # No Color

## Aliases and small fuctions
alias pro='cd ~/profile'

alias vim="nvim"
alias v=vim
alias vs="vim -c \"lua require('persistence').load({ last = true })\""
alias vr="vim . -c 'Telescope oldfiles'"
alias vv="vim . -c 'Kindle'"
alias vm="vim . -c 'DiffviewOpen'"
alias vf='vim $(fzf)'
alias vvs="vim . -c 'lua PersistenceKindle()'"
alias vc="vim . -c 'CopilotChat'"

alias x=tmux
alias xn="tmux new -s"
alias xls="tmux ls"
alias xa="tmux a"
alias xat="tmux a -t"
alias xnuke="tmux kill-server"
alias xk="tmux kill-session"
alias xkt="tmux kill-session -t"

alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias edge='/Applications/Microsoft\ Edge.app/Contents/MacOS/Microsoft\ Edge > /dev/null 2>&1'

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
alias tfi="terraform init"
alias tfws="terraform workspace list"
alias tfw-dev="terraform workspace select -or-create dev"
alias tfw-uat="terraform workspace select -or-create uat"
alias tfw-alpha="terraform workspace select -or-create alpha"
alias tfw-qa="terraform workspace select -or-create qa"
alias tfw-test="terraform workspace select -or-create test"
alias tfw-staging="terraform workspace select -or-create staging"
alias tfw-preprod="terraform workspace select -or-create preprod"
alias tfw-prod="terraform workspace select -or-create prod"

alias tfp="terraform plan -lock=false"
alias tfp-dev="tfw-dev && tfp -var-file='env/dev.tfvars'"
alias tfp-uat="tfw-uat && tfp -var-file='env/uat.tfvars'"
alias tfp-alpha="tfw-alpha && tfp -var-file='env/alpha.tfvars'"
alias tfp-qa="tfw-qa && tfp -var-file='env/qa.tfvars'"
alias tfp-test="tfw-test && tfp -var-file='env/test.tfvars'"
alias tfp-staging="tfw-staging && tfp -var-file='env/staging.tfvars'"
alias tfp-preprod="tfw-preprod && tfp -var-file='env/preprod.tfvars'"
alias tfp-prod="tfw-prod && tfp -var-file='env/prod.tfvars'"

alias tfa="terraform apply -auto-approve"
alias tfa-dev="tfw-dev && terraform apply -auto-approve -var-file='env/dev.tfvars'"
alias tfa-uat="tfw-uat && terraform apply -auto-approve -var-file='env/uat.tfvars'"
alias tfa-alpha="tfw-alpha && terraform apply -auto-approve -var-file='env/alpha.tfvars'"
alias tfa-qa="tfw-qa && terraform apply -auto-approve -var-file='env/qa.tfvars'"
alias tfa-test="tfw-test && terraform apply -auto-approve -var-file='env/test.tfvars'"
alias tfa-staging="tfw-staging && terraform apply -auto-approve -var-file='env/staging.tfvars'"
alias tfa-preprod="tfw-preprod && terraform apply -auto-approve -var-file='env/preprod.tfvars'"
alias tfa-prod="tfw-prod && terraform apply -auto-approve -var-file='env/prod.tfvars'"

alias python=python3
alias pyv="python3 -m venv venv"
alias pya="source venv/bin/activate"
alias pyd="deactivate"
alias pyi="pip install -r requirements.txt"

alias d=docker
alias dps="docker ps"
alias dls="docker images"
function drun() {
  docker image rm $@ 2>/dev/null
  docker build -t $@ . && docker run --name $@ -p 8000:8000 $@
}
# $NF is a special built-in variable that allows you to easily reference the last field of the current record (line) being processed.
function dbash() {
	CONTAINER=`docker ps | rg -v CONTAINER | awk '-F ' ' {print $NF}' | fzf --header CONTAINERS`
  if [ ! -z $CONTAINER ]
  then
    docker exec -it $CONTAINER bash
  fi
}
function dlogs() {
  CONTAINER_ROW=`docker ps --all --format "table {{.Names}}\t{{.Status}}" | rg -v NAMES | fzf --header CONTAINERS`
  if [ ! -z $CONTAINER_ROW ] # containes container name and status
  then
    CONTAINER=`echo $CONTAINER_ROW | awk '-F' ' ' '{print $1}'` # get name only
    docker logs -f $CONTAINER | less
  fi
}
function dkick() {
  CONTAINER=`docker ps --all | rg -v CONTAINER | awk '-F ' ' {print $NF}' | fzf --header CONTAINERS`
  if [ ! -z $CONTAINER ]
  then
    docker rm -f $CONTAINER
  fi
}
# aliased to drm
function drm-fzf() {
  CONTAINER=`docker ps --all | rg -v CONTAINER | awk '-F ' ' {print $NF}' | fzf --header CONTAINERS`
  if [ ! -z $CONTAINER ]
  then
    local image=`docker ps --all | grep $CONTAINER | awk '-F ' ' {print $2}'`

    echo "rm container and volume"
    docker rm --force --volumes $CONTAINER

    echo "rm image: $image"
    docker image rm $image
    echo "clean now"
  fi
}
# aliased to drr
function drr-fzf() {
  CONTAINER=`docker ps --all | rg -v CONTAINER | awk '-F ' ' {print $NF}' | fzf --header CONTAINERS`
  if [ ! -z $CONTAINER ]
  then
    local image=`docker ps --all | grep $CONTAINER | awk '-F ' ' {print $2}'`

    echo "rm container and volume"
    docker rm --force --volumes $CONTAINER

    echo "rm image: $image"
    docker image rm $image

    echo "build and start a new container: $CONTAINER"
    drun $CONTAINER
  fi
}
function ddel() {
  IMAGE=`docker images | rg -v REPOSITORY | awk '-F ' ' {print $1}' | fzf --header IMAGES`
  if [ ! -z $IMAGE ]
  then
    docker image rm $IMAGE
  fi
}
function dprune() {
    docker container prune -f
    docker system prune -f
}

alias cur="curl -include -w '\n\ntotal: %{time_total}s'"
alias curv="cur -verbose -raw"
alias curgloboff="cur --globoff"
alias curr="cur -raw"

curt() {
    crl -so /dev/null -w "\n\
   namelookup:  %{time_namelookup}s\n\
      connect:  %{time_connect}s\n\
   appconnect:  %{time_appconnect}s\n\
  pretransfer:  %{time_pretransfer}s\n\
     redirect:  %{time_redirect}s\n\
starttransfer:  %{time_starttransfer}s\n\
-------------------------\n\
        total:  %{time_total}s\n" "$@"
}

curj() {
  curl "$@" | jq
}

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
alias c=clear
alias pbpwd='pwd | pbcopy'

alias rgf='rg --files | rg'

alias git-whoami="git config user.email"
alias groot="git ma" # master/main branch
alias gt="git tree"
alias gtt="git full-tree"
alias gsp="git stash-pull"
alias sc-lazy="cd ~/profile/lazyvim/"
alias sc-lazyvim="v $HOME/.local/share/lazyvim/lazy"
gclone() {
  repo_name=$(echo "$@" | awk -F/ '{print $NF}' | sed 's/\.git$//')
  repo_dir="$HOME/src/$repo_name"

  git clone $@ $repo_dir
  cd $(echo $repo_dir)
}

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
alias mmalias="v ~/profile/zsh/aliases.zsh"
alias mmspell="v ~/profile/zsh/spells.zsh"
alias mmmackup="v ~/.mackup.cfg"
alias mmaws="v ~/.aws/config"
alias mmssh="v ~/.ssh/config"
alias mmgit="v ~/.config/git/config"
alias mmlg="v ~/.config/lazygit/config.yml"
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
alias ical='icalBuddy eventsToday | grep -E "•|location: http|oin the meeting|AM |PM |\d{2}:\d{2}\s*-\s*\d{2}:\d{2}" | grep -v "+1 " | grep -v "OOF" | grep -v "Leave" | grep -v "Sent:" | grep -v "When:"| grep -v "Cc:" | grep -v "\*\*"'
