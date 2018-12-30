#!/usr/bin/env bash
set -x
set -e

sudo apt update
sudo apt-get install -y software-properties-common

# --- ssh
if [ ! -e ~/.ssh/id_rsa.pub ]; then
    ssh-keygen -t rsa -b 4096
fi

# --- shell tools
# zsh
sudo apt install -y zsh

# on my zsh
if [ ! -e ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# fzf zsh
if [ ! -e ~/.fzf/install ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi

# tmux
sudo apt install -y tmux
cp ./configs/tmux.conf ~/.tmux.conf

# autojump
where autojump
if [ $? -ne 0 ]; then
    mkdir -p /tmp/autojump
    git clone git://github.com/wting/autojump.git /tmp/autojump
    cd /tmp/autojump
    ./install.py
    rm -rf /tmp/autojump
    cd ~
fi

# zsh config
cp ./configs/shrc_share ~/.zshrc_share
echo '[ -f ~/.shrc_share ] && source ~/.shrc_share' >> ~/.zshrc


# --- vim
# neovim
if [ -z $(where nvim) ]; then
    sudo add-apt-repository ppa:neovim-ppa/stable
    sudo apt-get update
    sudo apt-get install -y neovim
    sudo apt-get install -y python-dev python-pip python3-dev python3-pip
fi

# the ultimate vim config
if [ ! -e ~/.vim_runtime ]; then
    git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_awesome_vimrc.sh
fi

# let neovim know the above config
mkdir -p ~/.config/nvim
cp configs/init.vim ~/.config/nvim

# vim extra config
cp ./configs/my_configs.vim ~/.vim_runtime/


# --- git
cp ./configs/gitconfig ~/.gitconfig


echo "done"
