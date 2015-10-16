#!/bin/bash
echo "安装将花费一定时间，请耐心等待直到安装完成^_^"
if which apt-get >/dev/null; then
	sudo apt-get install -y ctags 
elif which yum >/dev/null; then
	sudo yum install -y ctags 
fi

##Add HomeBrew support on  Mac OS
if which brew >/dev/null;then
    echo "You are using HomeBrew tool"
    brew install ctags 
    ##Fix twisted installation Error in Mac caused by Xcode Version limit
    sudo ARCHFLAGS=-Wno-error=unused-command-line-argument-hard-error-in-future easy_install twisted
fi

sudo ln -s /usr/bin/ctags /usr/local/bin/ctags

#backup old_vim
mv -f ~/.vim ~/vim_old
mv -f ~/.vimrc ~/.vimrc_old

#ivim config
cd ~/ && git clone https://github.com/lostedleo/ivim.git ~/.vim
mv -f ~/.vim/vimrc ~/.vimrc
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

tmp_file=ivim_temp

echo "ivim正在努力为您安装bundle程序" > $tmp_file
echo "安装完毕将自动退出" >> $tmp_file
echo "请耐心等待" >> $tmp_file
vim $tmp_file -c "BundleInstall" -c "q" -c "q"
rm $tmp_file
echo "安装完成"
