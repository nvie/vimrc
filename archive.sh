#!/bin/sh
cd $(dirname $0)
cd ..
tar -czvLf vimrc.tgz \
    --exclude='vimrc/vim/view' \
    --exclude='.git' \
    --exclude='*.DS_Store' \
    --exclude='vimrc/vim/user.vim*' \
    --exclude='vim/NERDTreeBookmarks' \
    vimrc/*
