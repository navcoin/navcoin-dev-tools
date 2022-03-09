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

source ./ubuntu-xx-navcoin-core-dev-setup.sh
