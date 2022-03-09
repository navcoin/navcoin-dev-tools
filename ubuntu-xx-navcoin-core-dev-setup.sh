#!/bin/bash

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
