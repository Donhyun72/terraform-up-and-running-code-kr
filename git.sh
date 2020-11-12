#!/bin/bash

#git add $*
git add -A

#git config --global user.name "Donhyun72"
#git config --global user.email "try365@hanmail.net"

git commit -m "first commit"
#git branch -M main
git remote add origin https://github.com/Donhyun72/terraform-up-and-running-code-kr.git
git push origin master
