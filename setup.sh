#!/bin/bash

set -o errexit

echo 'Starting installation'

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