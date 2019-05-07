#!/bin/bash

echo "This script will install the packages and libraries required to build the NavCoin Core wallet dependancies"
echo "Do you wish to clone 'NAVCoin/navcoin-core' and build the dependancies for the master branch as well?"

read -p 'Enter Y for yes or anything else to decline: ' uservar

if [ $uservar == "Y" ]
then
  echo "The script will clone NavCoin Core and attempt to build the depends"
else
  echo "The script will not clone NavCoin Core"
fi

sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install -y git build-essential libcurl3-dev libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils libunbound-dev

sudo apt-get install -y libboost-all-dev

sudo apt-get install -y libminiupnpc-dev
sudo apt-get install -y libzmq3-dev 


#install qt5
sudo apt-get install -y libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler

sudo apt-get install -y libqrencode-dev curl


#install unbound
mkdir tmp
cd tmp
wget https://nlnetlabs.nl/downloads/unbound/unbound-1.7.3.tar.gz
tar xvfz unbound-1.7.3.tar.gz
cd unbound-1.7.3/
./configure
make
sudo make install
cd ..
rm -rf tmp

# workaround to support latest ubuntu
if [ `lsb_release -c | cut -f2` == 'disco' ]; then 
  echo "deb http://ppa.launchpad.net/bitcoin/bitcoin/ubuntu cosmic main" | sudo tee -a /etc/apt/sources.list 
  echo "deb-src http://ppa.launchpad.net/bitcoin/bitcoin/ubuntu cosmic main" | sudo tee -a /etc/apt/sources.list
else
  sudo add-apt-repository ppa:bitcoin/bitcoin
fi

sudo apt-get update
sudo apt-get install -y libdb4.8-dev libdb4.8++-dev

#install zmq so we can run our python tests
sudo apt-get install python3-zmq

if [ $uservar == "Y" ]
then
  #clone and build all the deps required
  git clone https://github.com/NAVCoin/navcoin-core
  cd navcoin-core
  git checkout master
  cd depends
  make
  cd ..
  ./autogen.sh
  ./configure --prefix=`pwd`/depends/x86_64-pc-linux-gnu --enable-debug --enable-tests
  make
fi
