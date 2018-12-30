#!/usr/bin/env bash
set -x
set -e

sudo apt update
sudo apt-get install -y software-properties-common

# --- ssh
ssh-keygen -t rsa -b 4096

# --- shell tools
# zsh
sudo apt install -y zsh

# on my zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# fzf zsh
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# tmux
sudo apt install -y tmux
cp ./configs/tmux.conf ~/.tmux.conf

# autojump
git clone git://github.com/wting/autojump.git ~/.autojump
cd ~/.autojump
./install.py
cd ~

# zsh config
cp ./configs/shrc_share ~/.zshrc_share
echo '[ -f ~/.shrc_share ] && source ~/.shrc_share' >> ~/.zshrc


# --- vim
# neovim
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install -y neovim
sudo apt-get install -y python-dev python-pip python3-dev python3-pip

# the ultimate vim config
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

# let neovim know the above config
mkdir -p ~/.config/nvim
cp configs/init.vim ~/.config/nvim

# vim extra config
cp ./configs/my_configs.vim ~/.vim_runtime/


# --- config
cp ./configs/gitconfig ~/.gitconfig
