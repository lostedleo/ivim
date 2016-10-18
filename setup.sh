#!/bin/bash
echo "ivim install vim plugins will task a new minutes, please waiting! ^_^"

function set_shell()
{
  function check_alias()
  {
    grep "~/.vim/alias" $1
  }

  command="source ~/.vim/alias"
  shell_name=~/.bashrc
  if [ -f ~/.zshrc ]; then
    shell_name=~/.zshrc

    check_alias $shell_name >/dev/null 2>&1
    if [ $? -ne 0 ];then
      echo $command| tee -a $shell_name
    fi
  else
    check_alias $shell_name >/dev/null 2>&1
    if [ $? -ne 0 ];then
      sed -i "N;2a${command}" $shell_name
    fi
  fi
}

#main
#start config vim and alias
#

if which apt-get >/dev/null 2>&1; then
  sudo apt-get install -y ctags ack cscope
elif which yum >/dev/null 2>&1; then
  sudo yum install -y ctags ack cscope
elif which brew >/dev/null 2>&1;then
  brew install ctags ack cscope
fi

if [ ! -f /usr/local/bin/ctags ];then
  sudo ln -s /usr/bin/ctags /usr/local/bin/ctags
fi

#exist ivim do't backup and git clone
if [ ! -f ~/.vim/setup.sh ];then
  #backup old_vim
  if [ -d ~/.vim ]; then
    mv -f ~/.vim ~/vim_old
  fi

  if [ -f ~/.vimrc ];then
    mv -f ~/.vimrc ~/.vimrc_old
  fi

  #ivim config
  cd ~/ && git clone https://github.com/lostedleo/ivim.git ~/.vim
fi

#set shell config
set_shell

#set vim config
ln -sf ~/.vim/vimrc ~/.vimrc
ln -sf ~/.vim/screenrc ~/.screenrc
ln -sf ~/.vim/tmux.conf ~/.tmux.conf
ln -sf ~/.vim/config ~/.ssh/config

#
if [ ! -d ~/.vim/bundle ];then
  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

  #install vim plugin
  tmp_file=ivim_temp
  echo "ivim installing bundle plugins" > $tmp_file
  echo "install completed will auto exit" >> $tmp_file
  echo "please wating..." >> $tmp_file
  vim $tmp_file -c "BundleInstall" -c "q" -c "q"
  rm $tmp_file
  echo "install completed!"
fi
