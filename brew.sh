/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install git
brew install --cask git-credential-manager
git clone https://github.com/arxhive/profile.git ~/profile

#fonts
cp ~/profile/nerd-fonts/* ~/Library/Fonts/

#terminal
brew install --cask iterm2
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
$ZSH_CUSTOM="~/.oh-my-zsh/custom"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/joshskidmore/zsh-fzf-history-search $SH_CUSTOM/plugins/zsh-fzf-history-search
git clone https://github.com/lukechilds/zsh-nvm $ZSH_CUSTOM/plugins/zsh-nvm
git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode
git clone https://github.com/kutsan/zsh-system-clipboard $ZSH_CUSTOM/plugins/zsh-system-clipboard
git clone https://github.com/Aloxaf/fzf-tab $ZSH_CUSTOM/plugins/fzf-tab

#devenv
brew install tmux
brew install tfenv
brew install cf2tf
brew install graphviz
brew install node
chmod go-w /opt/homebrew/Cellar
brew install jesseduffield/lazydocker/lazydocker
brew install prettier
brew install prettierd
brew install bat
brew install btop
brew install htop
brew install csvkit
# brew install grpcui

#gnu
brew install coreutils
brew install gawk
brew install base64
brew install findutils

#utils
brew install tree
brew install jq
brew install wget
brew install watch
brew install mitmproxy
brew install koekeishiya/formulae/skhd
skhd --start-service

#security
brew install trivy
brew install nmap

#os
# brew install --cask displaylink

#fuse
# brew install --cask macfuse
# brew install sshfs
# use macfuse on install sshfs on MacOs
# https://github.com/osxfuse/sshfs/releases

#vim
brew install nvim
brew install gnu-sed
brew install ripgrep
brew install lazygit
brew install ydiff
brew install lynx # used by nvim CopilotChat
mkdir -p ~/.config
ln -s ~/profile/lazyvim ~/.config/lazyvim
ln -s ~/profile/dotfiles/.config/git ~/.config/git

#python
brew install pyenv
git clone https://github.com/momo-lab/pyenv-install-latest.git "$(pyenv root)"/plugins/pyenv-install-latest
pyenv install-latest
brew install pyenv-virtualenv

#go
brew install golang
brew install golangci-lint
go install github.com/segmentio/golines@latest
# go install github.com/cweill/gotests@latest
go install gotest.tools/gotestsum@latestg
go install golang.org/x/tools/cmd/callgraph@latest
go install golang.org/x/tools/cmd/gorename@latest
go install golang.org/x/tools/cmd/gonew@latest
go install go.uber.org/mock/mockgen@latest
go install github.com/davidrjenni/reftools/cmd/fillswitch@latest
go install github.com/davidrjenni/reftools/cmd/fillstruct@latest
go install golang.org/x/vuln/cmd/govulncheck@latest
go install github.com/kyoh86/richgo@latest
go install github.com/abenz1267/gomvp@latest
go install github.com/twpayne/go-jsonstruct/v3/cmd/gojsonstruct@latest
go install golang.org/x/tools/cmd/guru@latest
# curl -sL https://raw.githubusercontent.com/kevincobain2000/gobrew/master/git.io.sh | sh

#C#
# https://learn.microsoft.com/en-us/dotnet/core/install/macos
brew install --cask dotnet-sdk

#scala and spark
# brew install scala@2.12
# brew install apache-spark
# brew install sbt
# brew install coursier/formulas/coursier
# cs setup

# java
brew install openjdk
brew install maven

#nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
nvm install node

#sdkman
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

#apps
brew install --cask 1password
brew install --cask google-chrome
brew install --cask postman
brew install --cask slack
brew install --cask notion
brew install --cask spectacle
brew install --cask karabiner-elements
brew install --cask boop
brew install --cask sublime-text
brew install --cask zoom
brew install --cask postman
brew install --cask caffeine
brew install --cask orbstack
# brew install --cask docker
# brew install --cask visual-studio-code
brew install --cask spotify
brew install --cask calibre
brew install shortcat
brew install speedtest-cli
brew install alt-tab
brew install ical-buddy
brew install w3m
ln ~/profile/dotfiles/.w3m/config ~/.w3m/config
ln ~/profile/dotfiles/.w3m/keymap ~/.w3m/keymap

brew install mackup
echo "[storage]\nengine = file_system\npath = profile\ndirectory = mackup" >~/.mackup.cfg
mackup restore

bat cache --build

#unix
brew install plantuml
brew install --cask temurin

brew install telnet
brew install fd
brew install fzf
$(brew --prefix)/opt/fzf/install

#clouds
#brew install awscli
#brew install azure-cli

#database
#brew install postgresql
#brew services start postgresql
#brew install --cask datagrip

#jetbrain
#brew install --cask jetbrains-toolbox
#brew install --cask pycharm-ce
#brew install --cask intellij-idea-ce

#k8s
brew install kubectx
brew install kubecolor
brew install derailed/k9s/k9s
K9S_SKINS_OUT="$HOME/.config/k9s/skins"
mkdir -p "$K9S_SKINS_OUT"
curl -L https://github.com/catppuccin/k9s/archive/main.tar.gz | tar xz -C "$K9S_SKINS_OUT" --strip-components=2 k9s-main/dist
ln -sf ~/profile/dotfiles/.config/k9s/config.yaml ~/.config/k9s/config.yaml

#spotify marketplace
curl -fsSL https://raw.githubusercontent.com/spicetify/cli/main/install.sh | sh
curl -fsSL https://raw.githubusercontent.com/spicetify/marketplace/main/resources/install.sh | sh
#spicetify backup apply

#after
mkdir -p ~/src
mkdir -p ~/bin
mkdir -p ~/lib
mkdir -p ~/ext
mkdir -p ~/tmp
mkdir -p ~/box
mkdir -p ~/uml
mkdir -p ~/logs
mkdir -p ~/spells

#https://github.com/mingrammer/diagrams
# cd ~/uml
# python -m venv venv
# source venv/bin/activate
# pip install diagrams
# deactivate

cd ~/profile
git config user.name "Artem Kolomeetc"
git config user.email "artesdi@gmail.com"

rm ~/Library/Preferences/com.lwouis.alt-tab-macos.plist

# why? I have to use symlinks instead
# debug this concern next time because there is a mix of ln and cp at this time
cp -rf ~/profile/dotfiles/ ~/

#custom macos apps
ln -s ~/profile/macos/apps/LazyFinder.app /Applications/LazyFinder.app
source ~/profile/macos/apps/clear_notifications_install # $HOME/bin/

#k8s krew
(
  set -x
  cd "$(mktemp -d)" &&
    OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
    KREW="krew-${OS}_${ARCH}" &&
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
    tar zxvf "${KREW}.tar.gz" &&
    ./"${KREW}" install krew
)
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
kubectl krew install node-shell

#safaribooks
#console.log(JSON.stringify(document.cookie.split(';').map(c => c.split('=')).map(i => [i[0].trim(), i[1].trim()]).reduce((r, i) => {r[i[0]] = i[1]; return r;}, {})))
git clone https://github.com/lorenzodifuccia/safaribooks.git $HOME/ext
touch $HOME/ext/safaribooks/cookies.json
cd $HOME/ext/safaribooks/
source venv/bin/activate
pip3 install -r requirements.txt

# vmware
#brew install --cask vmware-fusion
#brew install --cask multipass
