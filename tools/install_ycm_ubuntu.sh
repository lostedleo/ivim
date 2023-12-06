#!/bin/bash

apt install -y cmake python3-dev build-essential
cd ~/.vim/bundle/YouCompleteMe && python3 install.py --all --force-sudo --verbose

