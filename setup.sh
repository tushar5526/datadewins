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

# Slide 3

files=(data tmp)
for i in ${files[@]}; do
	tmp=$(find ~ -type d -name $i)
	if [[ -z $tmp ]]; then
		mkdir ~/$i
		echo "Creating $i Folder"
		continue
	fi
	echo "Dir $i already exists"
done

# Slide 4
touch ~/data/packages.list
packages=(vim gtypist mdp git)
echo -n > ~/data/packages.list
for i in ${packages[@]}; do 
	echo $i >> ~/data/packages.list
done

touch ~/data/users.list
packages=(user1 user2 user3)
echo -n > ~/data/users.list
for i in ${packages[@]}; do
        echo $i >> ~/data/users.list
done

echo "Succesfully added the data"


# Slide 5
tmp=$(find ~/data -type f -name packages.list)
if [[ -z $tmp ]]; then
	echo "packages.list not found"
	exit
fi
echo $tmp
while IFS= read -r line; do 
	apt install $line;
	echo 'Installed '$line; 
done < $tmp


