/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install git
brew install --cask git-credential-manager
git clone https://github.com/arxhive/profile.git ~/profile

#fonts
cp ~/profile/nerd-fonts/* ~/Library/Fonts/

#terminal
brew install --cask iterm2
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
git clone https://github.com/lukechilds/zsh-nvm $ZSH_CUSTOM/plugins/zsh-nvm
# git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode

#devenv
brew install tfenv
brew install wget
brew install jq
brew install graphviz
brew install node
chmod go-w /opt/homebrew/Cellar
brew install jesseduffield/lazydocker/lazydocker
# brew install grpcui

#gnu
brew install base64
brew install findutils

#security
brew install trivy
brew install nmap

#os
# brew install --cask displaylink

#fuse
brew install --cask macfuse
# brew install sshfs
# use macfuse on install sshfs on MacOs
# https://github.com/osxfuse/sshfs/releases

#vim
brew install nvim
brew install gnu-sed
brew install ripgrep
brew install lazygit
brew install ydiff
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
# curl -sL https://raw.githubusercontent.com/kevincobain2000/gobrew/master/git.io.sh | sh

#C#
# https://learn.microsoft.com/en-us/dotnet/core/install/macos
brew install --cask dotnet-sdk

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
brew install --cask gitkraken
brew install --cask spectacle
brew install --cask karabiner-elements
brew install --cask boop
brew install --cask sublime-text
brew install --cask zoom
brew install --cask postman
brew install --cask caffeine
brew install --cask docker
brew install --cask visual-studio-code
brew install --cask spotify

brew install speedtest-cli
brew install alt-tab

brew install mackup
echo "[storage]\nengine = file_system\npath = profile\ndirectory = mackup" >~/.mackup.cfg
mackup restore

#unix
brew install plantuml
brew install --cask temurin

brew install telnet
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
brew install kubecolor
brew install derailed/k9s/k9s
OUT="${XDG_CONFIG_HOME:-$HOME/Library/Application Support}/k9s/skins"
mkdir -p "$OUT"
curl -L https://github.com/catppuccin/k9s/archive/main.tar.gz | tar xz -C "$OUT" --strip-components=2 k9s-main/dist
ln -sf ~/profile/dotfiles/Library/Application\ Support/k9s/config.yaml ~/Library/Application\ Support/k9s/config.yaml

#after
mkdir -p ~/logs
mkdir -p ~/sources
mkdir -p ~/sources/diagrams

#https://github.com/mingrammer/diagrams
cd ~/sources/diagrams
python -m venv venv
source venv/bin/activate
pip install diagrams
deactivate

cd ~/profile
git config user.name "Artem Kolomeetc"
git config user.email "artesdi@gmail.com"

rm ~/Library/Preferences/com.lwouis.alt-tab-macos.plist
cp -rf ~/profile/dotfiles/ ~/

#symlinks
ln -s ~/profile/macos/apps/LazyFinder.app /Applications/LazyFinder.app
