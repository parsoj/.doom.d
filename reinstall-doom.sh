#!/bin/bash

pkill Emacs
cd ~/
rm -rf ~/doom-emacs
git clone -b develop https://github.com/hlissner/doom-emacs ~/doom-emacs
cd ~/doom-emacs
sed 's/setq load-prefer-newer noninteractive/setq load-prefer-newer nil/g' init.el > init_new.el
cp init_new.el init.el
bin/doom -y quickstart
