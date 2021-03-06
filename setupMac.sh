#!/bin/sh

# Setup script for the ev3dev system. This script runs on the Mac from my EV3 folder.
#
# This script presumes you have already generated an SSH public key on the Mac.
#
#  This is intended to be run on a freshly-created and booted ev3dev SD card image.
#


# Copy the RSA key to the EV3
#
echo "Copy the RSA key to the EV3..."

if [ -f ~/.ssh/id_rsa.pub ]
then
	scp ~/.ssh/id_rsa.pub robot@ev3dev.local:/tmp
else
	echo "*** RSA public key missing"
	exit 1
fi



# Copy the setup stuff from the Mac to the user directory on the EV3
#
echo "Copying the setup stuff to the EV3..."

scp Setup/* robot@ev3dev.local:~/


if [ -d Scripts ]
then
	echo "Copying the robot scripts to the EV3..."
	scp -r Scripts/* robot@ev3dev.local:~/
else
	echo "Scripts folder missing, not copied."
fi


echo "All done!"
echo "Now SSH to the EV3 and run the setupEV3.sh script there to finish the setup process."
