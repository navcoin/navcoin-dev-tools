wget http://mirrordirector.raspbian.org/raspbian/pool/main/libt/libtool/libltdl7_2.4.6-2_armhf.deb 
wget http://mirrordirector.raspbian.org/raspbian/pool/main/libs/libsodium/libsodium18_1.0.11-2_armhf.deb 
wget http://mirrordirector.raspbian.org/raspbian/pool/main/d/dnscrypt-proxy/dnscrypt-proxy_2.0.16-2_armhf.deb 

sudo dpkg -i libltdl7_2.4.6-2_armhf.deb 
sudo dpkg -i libsodium18_1.0.11-2_armhf.deb 
sudo dpkg -i dnscrypt-proxy_2.0.16-2_armhf.deb 

sudo apt-get -f install
