#!/bin/zsh

function linkfile {
        ln -sf `pwd`/$1 ~/
}

linkfile .tmux.conf
linkfile .vimrc
