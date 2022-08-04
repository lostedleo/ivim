#!/bin/bash
echo "ivim install vim plugins will task a new minutes, please waiting! ^_^"

function set_shell() {
  function check_alias() {
    grep "~/.vim/alias" $1
  }

  function set_command() {
    cat >> $1 <<- EOF
source ~/.vim/alias
[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u
EOF
  }

  shell_name=~/.bashrc
  if [ -f ~/.zshrc ]; then
    shell_name=~/.zshrc
  fi

  check_alias $shell_name >/dev/null 2>&1
  if [ $? -ne 0 ];then
    set_command $shell_name
  fi
}

#install brew for Mac
if [ "$(uname)" == "Darwin" ];then
  # if brew not exist then install it
  if ! $(command -v brew > /dev/null); then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
fi

#main
#start config vim and alias
#
if which apt-get >/dev/null 2>&1; then
  sudo apt-get install -y ctags ack cscope silversearcher-ag
elif which yum >/dev/null 2>&1; then
  sudo yum install -y ctags ack cscope the_silver_searcher
elif which brew >/dev/null 2>&1;then
  brew install ctags ack cscope tmux the_silver_searcher
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

#install efficient tools
#install ohmyzsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#install omz plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

#install autojump
git clone https://github.com/wting/autojump.git ~/.temp/autojump
cd ~/.temp/autojump && ./install.py && cd -

#set shell config
set_shell
#set vim config
ln -sf ~/.vim/vimrc ~/.vimrc
ln -sf ~/.vim/screenrc ~/.screenrc
ln -sf ~/.vim/tmux.conf ~/.tmux.conf
mkdir -p ~/.ssh/control
ln -sf ~/.vim/config ~/.ssh/config

#install all vim plugins
if [ ! -d ~/.vim/bundle ];then
  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

  #install vim plugin
  tmp_file=~/.vim/ivim_temp
  echo "ivim installing bundle plugins" > $tmp_file
  echo "install completed will auto exit" >> $tmp_file
  echo "please wating..." >> $tmp_file
  vim $tmp_file -c "BundleInstall" -c "q" -c "q"
  rm $tmp_file
  ~/.vim/bundle/fzf/install
  echo "install completed!"
fi
