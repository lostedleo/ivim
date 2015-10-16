#!/bin/bash
echo "安装将花费一定时间，请耐心等待直到安装完成^_^"
if which apt-get >/dev/null; then
	sudo apt-get install -y vim vim-gnome ctags xclip astyle python-setuptools python-dev git
elif which yum >/dev/null; then
	sudo yum install -y gcc vim git ctags xclip astyle python-setuptools python-devel
fi

##Add HomeBrew support on  Mac OS
if which brew >/dev/null;then
    echo "You are using HomeBrew tool"
    brew install vim ctags git astyle
    ##Fix twisted installation Error in Mac caused by Xcode Version limit
    sudo ARCHFLAGS=-Wno-error=unused-command-line-argument-hard-error-in-future easy_install twisted
fi

sudo easy_install -ZU autopep8 twisted
sudo ln -s /usr/bin/ctags /usr/local/bin/ctags
mv -f ~/vim ~/vim_old
cd ~/ && git git@github.com:lostedleo/ivim.git ~/.vim
mv -f ~/.vim ~/.vim_old
mv -f ~/.vimrc ~/.vimrc_old
mv -f ~/.vim/.vimrc ~/
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
echo "ivim正在努力为您安装bundle程序" > ivim
echo "安装完毕将自动退出" >> ivim
echo "请耐心等待" >> ivim
vim ivim -c "BundleInstall" -c "q" -c "q"
rm ivim
echo "安装完成"
