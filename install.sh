#!/bin/zsh

function linkfile {
        ln -sf `pwd`/$1 ~/
}

linkfile .zshrc
linkfile .tmux.conf
linkfile .vimrc
