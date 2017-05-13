#!/bin/sh

# Setup script for the ev3dev system. This script runs on the EV3 itself, from the default home directory.
#
# Steps to do on the Mac before running this script:
#
#   1) Copy the RSA key to the EV3
#        > scp ~/.ssh/id_rsa.pub robot@ev3dev.local:/tmp
#
#   2) Copy the setup and script dir contents from the Mac to the user directory on the EV3
#        > cd <setup>
#        > scp * robot@ev3dev.local:~/
#        > cd <scripts>
#        > scp * robot@ev3dev.local:~/
#
#
# The 'setupMac.sh' script will do these steps when run on the host computer.


# Install the Ruby gem that lets us remote edit with TextMate
#
echo "Installing rmate..."

sudo gem install rmate




# Copy the Mac's public key to the authorized key list on the EV3
#
# This assumes that the key has been copied from the mac to the EV3 prior to running this script:
#   scp ~/.ssh/id_rsa.pub robot@ev3dev.local:/tmp
#
echo  "Setup up the RSA key for the Mac..."

if [ -f "/tmp/id_rsa.pub" ]
then
	mkdir ~/.ssh
	cat /tmp/id_rsa.pub >> ~/.ssh/authorized_keys
	rm /tmp/id_rsa.pub
else
	echo "*** Unable to setup the RSA key, was not sent over from the Mac?"
fi


# Install the FTP server
#

if [ -d /usr/lib/python2.7/pyftpdlib ]
then
	echo "Python FTP lib already installed"
else
	echo "Installing Python FTP library..."

	wget https://pypi.python.org/packages/source/p/pyftpdlib/pyftpdlib-1.5.0.tar.gz
	gunzip pyftpdlib-*
	tar -xf pyftpdlib*.tar
	sudo mv pyftpdlib-1.5.0/pyftpdlib /usr/lib/python2.7
	rm -rf pyftpdlib*
fi



if [ -f /etc/init.d/ftpserver ]
then
	echo "FTP server already installed"
else
	echo "Setting up FTP server..."
	sudo mv ftpserver /etc/init.d/ftpserver
	sudo chmod +x /etc/init.d/ftpserver
	sudo update-rc.d ftpserver defaults
fi



# Make the default Python scripts executable
#
echo "Making default Python scripts executable..."

chmod +x *.py



echo "Setup complete"
