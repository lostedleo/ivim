#!/bin/bash
echo "安装将花费一定时间，请耐心等待直到安装完成^_^"

if which apt-get >/dev/null; then
	sudo apt-get install -y ctags ack
elif which yum >/dev/null; then
	sudo yum install -y ctags ack
elif which brew >/dev/null;then
    echo "You are using HomeBrew tool"
    brew install ctags ack
fi

sudo ln -s /usr/bin/ctags /usr/local/bin/ctags

#backup old_vim
mv -f ~/.vim ~/vim_old
mv -f ~/.vimrc ~/.vimrc_old

#ivim config
cd ~/ && git clone https://github.com/lostedleo/ivim.git ~/.vim
ln -sf ~/.vim/vimrc ~/.vimrc
ln -sf ~/.vim/screenrc ~/.screenrc
ln -sf ~/.vim/tmux.conf ~/.tmux.conf
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

tmp_file=ivim_temp

echo "ivim正在努力为您安装bundle程序" > $tmp_file
echo "安装完毕将自动退出" >> $tmp_file
echo "请耐心等待" >> $tmp_file
vim $tmp_file -c "BundleInstall" -c "q" -c "q"
rm $tmp_file
echo "安装完成"
