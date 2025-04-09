
## Aliases and small fuctions
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
alias pyv="python3 -m venv venv"
alias pya="source venv/bin/activate"
alias pyd="deactivate"
alias pyi="pip install -r requirements.txt"

alias d=docker
alias dps="docker ps"

alias curl="curl -include"
alias curlv="curl -verbose -raw"
alias curlr="curl -raw"

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
alias ical='icalBuddy eventsToday | grep -E "•|location: http|oin the meeting|AM |PM |\d{2}:\d{2}\s*-\s*\d{2}:\d{2}" | grep -v "+1 " | grep -v "OOF" | grep -v "Leave" | grep -v "Sent:" | grep -v "When:"| grep -v "Cc:" | grep -v "\*\*"'
