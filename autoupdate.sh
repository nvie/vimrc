#!/bin/bash

cd vim

echo update vim-git syntax
curl --silent -L https://github.com/tpope/vim-git/tarball/master | tar xzf - --strip-components=1

echo update pathogen
curl --silent -Lo autoload/pathogen.vim https://github.com/tpope/vim-pathogen/raw/master/autoload/pathogen.vim

echo update markdown support
curl --silent -L https://github.com/tpope/vim-markdown/tarball/master | tar xzf - --strip-components=1
