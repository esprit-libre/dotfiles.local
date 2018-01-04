#init
RUBY_VERSION="2.4.0"

#upgdate
sudo apt-get update
sudo apt-get upgrade
sudo apt-get -f install

#Zsh
sudo apt-get install -y vim curl wget zsh
chsh -s $(which zsh)

#OhMyZSH
curl -L http://install.ohmyz.sh | sh
#OMZ plugin
cd ~/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone git://github.com/zsh-users/zsh-autosuggestions

#Powerline font
mkdir -p ~/.fonts/ && cd ~/.fonts/
wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
fc-cache -vf ~/.fonts
mkdir -p ~/.config/fontconfig/conf.d/ && cd ~/.config/fontconfig/conf.d/
wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf

# fonts
sudo apt install gsfonts-x11

#OMZ themes
cd $HOME/.oh-my-zsh/themes/
curl https://gist.githubusercontent.com/cchaudier/1ac45d7a72babaafb08c/raw/808d596d63f864f7a7a8cc7c7ee6a3f5730398ae/myagnoster.zsh-theme > myagnoster.zsh-theme

#rcm
wget -qO - https://apt.thoughtbot.com/thoughtbot.gpg.key | sudo apt-key add -
echo "deb http://apt.thoughtbot.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/thoughtbot.list
sudo apt-get update
sudo apt-get install rcm
cd
if [ -d dotfiles ]; then
  cd dotfiles
  git pull
else
   git clone git@github.com:thoughtbot/dotfiles.git
fi
cd
env RCRC=$HOME/dotfiles/rcrc rcup -x tools

#Dev tools
sudo apt-get install -y htop dfc git-flow python-pip libssl-dev libreadline-dev zlib1g-dev

#Rbenv
cd
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
git clone https://github.com/tarruda/zsh-autosuggestions ~/.zsh-autosuggestions
~/.rbenv/bin/rbenv init
rbenv install -l |grep $RUBY_VERSION && \
rbenv install $RUBY_VERSION && \
rbenv global $RUBY_VERSION

#Tmux
sudo apt-get install -y tmux
gem install tmuxinator

#tmate.io
sudo apt-get install software-properties-common && \
sudo add-apt-repository ppa:tmate.io/archive    && \
sudo apt-get update                             && \
sudo apt-get install tmate

#Docker
docker -v || curl -fsSL https://get.docker.com/ | sh

#Vagrant
mkdir -p /tmp/install_vagrant
cd /tmp/install_vagrant
wget https://releases.hashicorp.com/vagrant/1.9.1/vagrant_1.9.1_x86_64.deb
sudo dpkg -i vagrant_*.deb
cd /tmp && rm -rf /tmp/install_vagrant

#Virtualbox
sudo apt-get install -y libsdl1.2debian libqt5x11extras5
mkdir -p /tmp/install_virtualbox
cd /tmp/install_virtualbox
wget http://download.virtualbox.org/virtualbox/5.1.18/virtualbox-5.1_5.1.18-114002~Ubuntu~xenial_amd64.deb
sudo dpkg -i virtualbox*.deb
cd /tmp && rm -rf /tmp/install_virtualbox

#My bins
cd ~/.bin
curl -sL https://asciinema.org/install | sh

#Dropbox
mkdir -p /tmp/install_dropbox
cd /tmp/install_dropbox
wget https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2015.10.28_amd64.deb
sudo dpkg -i *.deb
cd /tmp && rm -rf /tmp/install_dropbox
dropbox start -i

#My dev dir
cd ~
mkdir -p dev/clients
mkdir -p dev/app
mkdir -p dev/env
mkdir -p dev/tmp

#Wallpapers
sudo apt-get install -y wallch

#Nemo
echo -e "\r"|sudo add-apt-repository ppa:webupd8team/nemo
sudo apt-get update
sudo apt-get install nemo
xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search

#Franz (chat client)
if [[ ! -e /opt/meetfranz/Franz ]]; then
  mkdir -p /tmp/meetfranz
  cd /tmp/meetfranz
  wget https://github.com/meetfranz/franz-app/releases/download/4.0.4/Franz-linux-x64-4.0.4.tgz
  tar -xzf Franz-linux-x64-4.0.4.tgz
  rm -rf Franz-linux-x64-4.0.4.tgz
  cd
  sudo chown -R root:root meetfranz
  sudo mv meetfranz /opt
fi

#multi-system
sudo apt-add-repository 'deb http://liveusb.info/multisystem/depot all main'
wget -q http://liveusb.info/multisystem/depot/multisystem.asc -O- | sudo apt-key add -
sudo apt-get update
sudo apt-get install multisystem

#ansible
pip install --upgrade pip
pip install ansible ansible-lint

#Atom
mkdir -p /tmp/install_atom
cd /tmp/install_atom
wget https://atom.io/download/deb -O atom.deb
sudo dpkg -i *.deb
cd /tmp && rm -rf /tmp/install_atom
apm install language-terraform
apm install language-tmux
apm install language-ansible
apm install file-icons
apm install tree-view-git-status
apm install ansible-vault
apm install linter-ansible-linting
apm install Linter-Ansible-Syntax
apm install ansible-snippets
apm install autocomplete-ansible
apm install railscast-theme
apm install merge-conflicts
apm install indent-tooltip
apm install indent-guide-improved
apm install auto-indent

#DNS utils
sudo apt-get install dnsutils
