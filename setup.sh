#! /bin/bash
# Copyright (C) 2020 sergio b
#
# Distributed under terms of the MIT license.
#

cleanup () {
  rm -rf ./aws
  rm awscliv2.zip
}
trap cleanup EXIT

python3 -m pip install --upgrade pip
pip install flask
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip
unzip awscliv2.zip
sudo ./aws/install

wget https://github.com/99designs/aws-vault/releases/download/v6.2.0/aws-vault-linux-amd64
mv aws-vault-linux-amd64 /home/codespace/.local/bin/aws-vault
chmod +x /home/codespace/.local/bin/aws-vault

git config --global alias.ci commit
git config --global alias.co checkout
git config --global alias.fetch fetch --all --prune
git config --global alias.logo log --graph --decorate --abbrev-commit --all --pretty=oneline
git config --global alias.st status -sb
git config --global alias.tst status -sb
git config --global alias.up !git fetch && git pull
git config --global color.branch auto
git config --global color.status auto
git config --global color.ui auto
git config --global color.diff.meta blue
git config --global color.diff.new green
git config --global color.diff.old red strike
git config --global core.autocrlf false
git config --global core.editor vim
git config --global core.filemode false
git config --global diff.compactionheuristic true
git config --global diff.wserrorhighlight all
git config --global fetch.prune true
git config --global github.user=sergiobuj
git config --global help.autocorrect 15
git config --global merge.tool opendiff
git config --global pull.default current
git config --global pull.ff only

sudo apt update

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt install terraform
