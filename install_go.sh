#!/usr/bin/env bash

set -x
which go
if [ $? -ne 0 ]; then
    fname=go1.10.3.linux-amd64.tar.gz
    wget https://dl.google.com/go/$fname
    sudo tar -xvf $fname
    sudo mv go /usr/local
    rm $fname
    go version
    go env
    echo 'export GOROOT=/usr/local/go' >> ~/.zshrc
    echo 'export GOPATH=$HOME/Projects/go-projects' >> ~/.zshrc
    echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> ~/.zshrc
    mkdir -p $GOPATH
    echo 'done'
else
    echo 'go already exists!'
fi
