#!/bin/bash

cd ~/
rm -rf .emacs.d
git clone -b develop https://github.com/hlissner/doom-emacs.git ~/.emacs.d
cd .emacs.d
bin/doom quickstart
