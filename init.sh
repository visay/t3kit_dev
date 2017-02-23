#!/usr/bin/env bash

cd shared
if [ ! -d "db" ]; then
    mkdir db
fi
cd db
if [ ! -d .git ]; then
    git clone https://github.com/t3kit/t3kit_db.git .
fi;
cd ..

if [ ! -d "site" ]; then
    mkdir site
fi
cd site
if [ ! -d .git ]; then
    git clone https://github.com/t3kit/t3kit.git .
    git submodule update --init --recursive
fi;
cd TYPO3.CMS
composer install
cd ../../..
ln -nfs vagrant/Vagrantfile Vagrantfile
ln -nfs docker/docker-compose.yml docker-compose.yml
