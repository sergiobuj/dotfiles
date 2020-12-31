#! /bin/bash
# Copyright (C) 2020 sergio b
#
# Distributed under terms of the MIT license.
#

set -ex

cleanup () {
  rm -rf "$tmpdir"
}
trap cleanup EXIT

tmpdir=$(mktemp -d) || exit 1

sudo apt update
sudo apt install -y software-properties-common

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

sudo apt update
sudo apt install -y terraform curl unzip

git config --global --replace-all alias.ci commit
git config --global --replace-all alias.co checkout
git config --global --replace-all alias.fetch 'fetch --all --prune'
git config --global --replace-all alias.logo 'log --graph --decorate --abbrev-commit --all --pretty=oneline'
git config --global --replace-all alias.st 'status -sb'
git config --global --replace-all alias.tst 'status -sb'
git config --global --replace-all alias.up '!git fetch && git pull'
git config --global --replace-all color.branch auto
git config --global --replace-all color.status auto
git config --global --replace-all color.ui auto
git config --global --replace-all color.diff.meta blue
git config --global --replace-all color.diff.new green
git config --global --replace-all color.diff.old 'red strike'
git config --global --replace-all core.autocrlf false
git config --global --replace-all core.editor vim
git config --global --replace-all core.filemode false
git config --global --replace-all diff.compactionheuristic true
git config --global --replace-all diff.wserrorhighlight all
git config --global --replace-all fetch.prune true
git config --global --replace-all github.user sergiobuj
git config --global --replace-all help.autocorrect 15
git config --global --replace-all merge.tool opendiff
git config --global --replace-all pull.default current
git config --global --replace-all pull.ff only

python3 -m pip install --upgrade pip
pip install flask

curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "$tmpdir/awscliv2.zip"
unzip "$tmpdir/awscliv2.zip" -d "$tmpdir/"
sudo "$tmpdir/aws/install"

curl -fsSL "https://github.com/99designs/aws-vault/releases/download/v6.2.0/aws-vault-linux-amd64" -o "$tmpdir/aws-vault"
sudo mv "$tmpdir/aws-vault" /usr/local/bin/aws-vault
sudo chmod +x /usr/local/bin/aws-vault

curl -fsSL "https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip" -o "$tmpdir/ngrok.zip"
unzip "$tmpdir/ngrok.zip" -d "/usr/local/bin/"

chsh --shell /bin/zsh root
