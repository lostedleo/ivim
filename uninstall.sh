#!/bin/sh
echo "restore vim config"

#del ivim
mv ~/.vim ~/.ivim
rm -rf ~/.vimrc
rm -rf ~/.screenrc
rm -rf ~/.tmux.conf

#restore config
if [ -f ~/.vimrc_old ];then
  mv -f ~/.vimrc_old ~/.vimrc
fi

if [ -d ~/.vim_old ];then
  mv -f ~/.vim_old ~/.vim
fi
