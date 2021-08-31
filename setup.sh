#!/bin/bash
fnrUser=$(id -un 1000)
for i in {1001..2000}
do
	if [[ $? == 0 ]];
	then
		echo "First non root user is "$fnrUser
		break
	fi
	fnrUser=$(id -un $i)
done
if [[ $? -ne 0 ]];
then
	echo "No first non user found in uids 1000 to 2000"
	exit
fi

echo "Adding $fnrUser to sudo group"
usermod -aG sudo $fnrUser
