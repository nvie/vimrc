#!/bin/sh
INSTALL_TO=~/Projects

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

install_vimrc () {
    [ -e "$INSTALL_TO/vimrc" ] && die "$INSTALL_TO/vimrc already exists."
    [ -e "~/.vim" ] && die "~/.vim already exists."
    [ -e "~/.vimrc" ] && die "~/.vimrc already exists."

    cd "$INSTALL_TO"
    git clone git://github.com/nvie/vimrc.git
    cd vimrc

    # Download vim plugin bundles
    git submodule init
    git submodule update

    # Symlink ~/.vim and ~/.vimrc
    cd ~
    ln -s "$INSTALL_TO/vimrc/vimrc" .vimrc
    ln -s "$INSTALL_TO/vimrc/vim" .vim
    touch ~/.vim/user.vim

    echo "Installed and configured .vim, have fun."
}

install_vimrc
