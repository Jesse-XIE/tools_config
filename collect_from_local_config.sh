#!/usr/bin/env bash

for file in \
    ~/.shrc_share \
    ~/.tmux.conf \
    ~/.gitconfig \
    ~/.vim_runtime/my_configs.vim \
    ~/.config/nvim/init.vim \
    ; do
name=$(basename $file)
name=${name#.}
[ -e $file ] && cp $file configs/$name
done

