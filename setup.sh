#!/bin/bash
# sh -c "$(wget -O- https://raw.githubusercontent.com/lostedleo/ivim/master/setup.sh)"
set -e
echo "ivim install vim plugins will task a few minutes, please waiting! ^_^"

DIR="$(cd "$(dirname "$0")" && pwd)"
if [ -t 1 ]; then
  is_tty() {
    true
  }
else
  is_tty() {
    false
  }
fi

# Adapted from code and information by Anton Kochkov (@XVilka)
# Source: https://gist.github.com/XVilka/8346728
supports_truecolor() {
  case "$COLORTERM" in
  truecolor|24bit) return 0 ;;
  esac

  case "$TERM" in
  iterm           |\
  tmux-truecolor  |\
  linux-truecolor |\
  xterm-truecolor |\
  screen-truecolor) return 0 ;;
  esac

  return 1
}

setup_color() {
  # Only use colors if connected to a terminal
  if ! is_tty; then
    FMT_RAINBOW=""
    FMT_RED=""
    FMT_GREEN=""
    FMT_YELLOW=""
    FMT_BLUE=""
    FMT_BOLD=""
    FMT_RESET=""
    return
  fi

  if supports_truecolor; then
    FMT_RAINBOW="
      $(printf '\033[38;2;255;0;0m')
      $(printf '\033[38;2;255;97;0m')
      $(printf '\033[38;2;247;255;0m')
      $(printf '\033[38;2;0;255;30m')
      $(printf '\033[38;2;77;0;255m')
      $(printf '\033[38;2;168;0;255m')
      $(printf '\033[38;2;245;0;172m')
    "
  else
    FMT_RAINBOW="
      $(printf '\033[38;5;196m')
      $(printf '\033[38;5;202m')
      $(printf '\033[38;5;226m')
      $(printf '\033[38;5;082m')
      $(printf '\033[38;5;021m')
      $(printf '\033[38;5;093m')
      $(printf '\033[38;5;163m')
    "
  fi

  FMT_RED=$(printf '\033[31m')
  FMT_GREEN=$(printf '\033[32m')
  FMT_YELLOW=$(printf '\033[33m')
  FMT_BLUE=$(printf '\033[34m')
  FMT_BOLD=$(printf '\033[1m')
  FMT_RESET=$(printf '\033[0m')
}

check_config_exit() {
  grep "$1" $2 > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    return 0
  else
    return 1
  fi
}

set_command() {
  cat >> $1 <<- EOF
source ~/.vim/config/alias
[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u
EOF
}

set_shell() {
  shell_name=~/.bashrc
  if [ -f ~/.zshrc ]; then
    shell_name=~/.zshrc
  fi

  if ! $(check_config_exit "~/.vim/config/alias" $shell_name); then
    set_command $shell_name
  fi
}

install_apps() {
  #install brew for Mac
  if [ "$(uname)" == "Darwin" ];then
    # if brew not exist then install it
    if ! $(command -v brew > /dev/null); then
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
  fi

# install apps
  if which apt-get >/dev/null 2>&1; then
    sudo apt-get install -y universal-ctags ack cscope tmux silversearcher-ag git zsh expect
  elif which yum >/dev/null 2>&1; then
    yum install -y ctags ack cscope tmux the_silver_searcher git zsh expect
  elif which brew >/dev/null 2>&1;then
    brew install ctags ack cscope tmux the_silver_searcher gsed git zsh expect
  fi

  if [ ! -f /usr/local/bin/ctags ];then
    ln -s /usr/bin/ctags /usr/local/bin/ctags
  fi
}

backup_vim() {
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
}

#install efficient tools

#install ohmyzsh
install_omz() {
  if [ -d ~/.oh-my-zsh ];then
    echo "${FMT_YELLOW}Found oh-my-zsh, not to install oh-my-zsh${FMT_RESET}"
    return
  fi

  mkdir -p ${DIR}/.temp
  wget -O ${DIR}/.temp/omz_install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh

  /usr/bin/expect << EOF
  spawn bash ${DIR}/.temp/omz_install.sh
  expect {
    "Y/n" { send "y\n" }
  }
  expect eof
EOF

  rm -rf ${DIR}/.temp
  #install omz plugins
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  sed -i.bak 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

  echo "${FMT_GREEN}Install oh-my-zsh success!${FMT_RESET}"
}

#install autojump
install_autojump() {
  if [ -d ~/.autojump ]; then
    echo "${FMT_YELLOW}Found autojump, not to install!${FMT_RESET}"
    return
  fi

  autojump_dir=~/.temp/autojump
  git clone https://github.com/wting/autojump.git ${autojump_dir}
  cd ~/.temp/autojump && ./install.py && cd -

  rm -rf ${autojump_dir}
  echo "${FMT_GREEN}Install autojump success!${FMT_RESET}"
}

check_link() {
  if [ ! -L $2 ];then
    ln -s $1 $2
  fi
}

#set link config
set_link() {
  check_link ~/.vim/vimrc ~/.vimrc
  check_link ~/.vim/config/screenrc ~/.screenrc
  check_link ~/.vim/config/tmux.conf ~/.tmux.conf
  mkdir -p ~/.ssh/control
  check_link ~/.vim/config/ssh_config ~/.ssh/config
}

install_fzf() {
  if [ -d ~/.fzf ];then
    echo "${FMT_YELLOW}Found fzf, not to install!${FMT_RESET}"
    return
  fi

  /usr/bin/expect << EOF
  spawn ~/.vim/bundle/fzf/install
  expect {
    "/n" { send "y\r"; exp_continue}
  }
EOF
}

#install all vim plugins
install_vim_plugins() {
  if [ ! -d ~/.vim/bundle ];then
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

    #install vim plugin
    tmp_file=~/.vim/ivim_temp
    echo "ivim installing bundle plugins" > $tmp_file
    echo "install completed will auto exit" >> $tmp_file
    echo "please wating..." >> $tmp_file
    vim $tmp_file -c "BundleInstall" -c "q" -c "q"
    rm $tmp_file

    install_fzf
    echo "${FMT_GREEN}install vim plugins and fzf!${FMT_RESET}"
  fi
}

source_shell() {
  shell_name=~/.bashrc
  if [ -f ~/.zshrc ]; then
    shell_name=~/.zshrc
  fi
  source ${shell_name}
}

install_apps_and_tools() {
  install_apps
  install_omz
  install_autojump
}

set_config() {
  set_link
  set_shell
}

main() {
  setup_color
  # first install apps and tools
  install_apps_and_tools
  # second backup old vim and vimrc
  backup_vim
  # then install vim plugins
  install_vim_plugins
  # set config and source shell
  set_config

  echo "${FMT_GREEN}Success install ivim!${FMT_RESET}"
  # last load zsh and source shell
  zsh -l && source_shell
}

main
