#!/bin/bash
echo "安装将花费一定时间，请耐心等待直到安装完成^_^"

function set_shell()
{
  command="source ~/.vim/alias"

  function check_alias()
  {
    cmd="grep ~/.vim/alias $1"
    cmd=`$cmd`
      if [ "${cmd}xyz" != "xyz" ];then
        return 0
      else
        return -1
      fi
  }

  shell_name=~/.bashrc
  if [ -f ~/.zshrc ]; then
    shell_name=~/.zshrc
    check_alias $shell_name
    ret=$?

    if [ $ret -ne 0 ];then
      echo $command > /dev/null | tee -a $shell_name
    fi
  else
    check_alias $shell_name
    ret=$?

    if [ $ret -ne 0 ];then
      sed -i 'N;2${command}' $shell_name
    fi
  fi
}

if which apt-get >/dev/null; then
  sudo apt-get install -y ctags ack cscope
elif which yum >/dev/null; then
  sudo yum install -y ctags ack cscope
elif which brew >/dev/null;then
  echo "You are using HomeBrew tool"
  brew install ctags ack cscope
fi

sudo ln -s /usr/bin/ctags /usr/local/bin/ctags

#backup old_vim
if [ -d ~/.vim ]; then
  mv -f ~/.vim ~/vim_old
fi

if [ -f ~/.vimrc ];then
  mv -f ~/.vimrc ~/.vimrc_old
fi

#ivim config
cd ~/ && git clone https://github.com/lostedleo/ivim.git ~/.vim

#set shell config
set_shell

#set vim config
ln -sf ~/.vim/vimrc ~/.vimrc
ln -sf ~/.vim/screenrc ~/.screenrc
ln -sf ~/.vim/tmux.conf ~/.tmux.conf
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

#install vim plugin
tmp_file=ivim_temp
echo "ivim正在努力为您安装bundle程序" > $tmp_file
echo "安装完毕将自动退出" >> $tmp_file
echo "请耐心等待" >> $tmp_file
vim $tmp_file -c "BundleInstall" -c "q" -c "q"
rm $tmp_file
echo "安装完成"
