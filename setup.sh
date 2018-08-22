#!/bin/bash

set -o errexit

echo 'Starting installation'

WORKDIR=~/.personal_setup

if [ ! -n "$WORKDIR"] ; then
	WORKDIR=~/.personal_setup
fi

if [ -d "$WORKDIR" ]; then
	rm -rf $WORKDIR
fi

wget https://github.com/mariusbreivik/macos-ansible/archive/master.zip -P $WORKDIR
cd $WORKDIR
unzip -o master.zip

echo 'Checking if xcode command line tools is installed'
if [ ! xcode-select --print-path &> /dev/null ]; then
    echo 'Installing Xcode command line tools'

    xcode-select --install &> /dev/null

    echo 'done'

else
    echo 'Xcode command line tools already installed' 
fi

echo 'Checking if homebrew is installed'

if [ -z $(which brew) ]; then
    echo 'Installing homebrew'
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "done"
else
    echo 'homebrew already installed'
fi

echo 'Checking if ansible is installed'

if [ -z $(which ansible) ]; then
    echo 'Installing ansbile'
    brew install ansible
fi


echo 'let ansible do some magic'
ansible-playbook playbooks/homebrew.yml