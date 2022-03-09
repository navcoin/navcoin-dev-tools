#!/bin/bash

echo "This script will install the packages and libraries required to build the NavCoin Core wallet dependancies"
echo "Do you wish to clone 'navcoin/navcoin-core' and build the dependancies for the master branch as well?"

read -p 'Enter Y for yes or anything else to decline: ' uservar

if [ $uservar == "Y" ]
then
  echo "The script will clone NavCoin Core and attempt to build the depends"
else
  echo "The script will not clone NavCoin Core"
fi

echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ bionic-rc main' | sudo tee -a /etc/apt/sources.list.d/kitware.list >/dev/null
sudo apt update
sudo apt upgrade -y

sudo apt install -y\
	autoconf \
	automake \
	binutils-aarch64-linux-gnu \
	binutils-arm-linux-gnueabihf \
	binutils-gold \
	bsdmainutils \
	ca-certificates \
	cmake \
	curl \
	faketime \
	g++-8-aarch64-linux-gnu \
	g++-8-arm-linux-gnueabihf \
	g++-8-multilib \
	g++-aarch64-linux-gnu \
	g++-arm-linux-gnueabihf \
	gcc-8-aarch64-linux-gnu \
	gcc-8-arm-linux-gnueabihf \
	gcc-8-multilib \
	git \
	libtool \
	pkg-config \
	python3 \
	python3-pip \
	python3-setuptools \
	libtinfo5 \
	libattr1-dev \

if [ $uservar == "Y" ]
then
  cd ~
  #clone and build all the deps required
  git clone https://github.com/navcoin/navcoin-core
  cd navcoin-core
  git checkout master
  cd depends
  make -j$(nproc)
  cd ..
  ./autogen.sh
  ./configure --enable-debug --enable-tests --prefix=`pwd`/depends/`uname -m`-pc-linux-gnu 
  make -j$(nproc)
fi
