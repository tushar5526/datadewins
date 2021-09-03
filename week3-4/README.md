# Week 3-4

## Slide 2

```                                                                     
Preparation steps:                                                           

+- Create bin directory in home ( ~ ) directory                             
+- Create a script ~/bin/setup.sh                                           
+- Implement all excercises in ~/bin/setup.sh, incrementally                
|   +- add solution for one problem                                         
|   +- run script to test it works                                          
|   +- move to next problem                                                 
+- Add the first non-root user to sudoers file.                             

HINT:                                                                        
+- install sudo package and use visudo command                              
+- make sure ~/bin is avaialable in PATH                                    
+- set execute permissions and add PATH entris appropriately                
+- make sure first sudo user is able to run commands with sudo              
```                                                                                     

**Solution:**
---------------

```
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
```

## Slide 3

```
Setup home directory                                                          

+- Create following directories in home directory                                 
+- data                                                                       
+- tmp                                                                        

HINT:                                                                              
+- use mkdir command                                                              
+- test if directory already exists                                               
+- if directory exists, no action needed                                      
+- else create directory                                                      
```

**Solution:**
---------------

```
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
```

## Slide 4

```
Create sample data:                                                                
...................                      

Let us populate some sample data in files for next steps                           
+- create file packages.list in ~/data directory                                  
+- populate packages.list with following content  

vim                                                                                
gtypist                                                                            
mdp                                                                                
git  

+- create file users.list in ~/data directory                                     │
+- populate users.list with following content  

```

**Solution:**
---------------

```
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
```

## Slide 5
```
Enhance ~/bin/setup.sh to:                                                         
..........................                                                         
Install packages                                                                   
+- Create a simple script ( ~/bin/setup.sh ) that                                
	+- checks if ~/data/packages.list file exists                                 
	+- reads ~/data/packages.list file                                            
	+- store each package name in a loop variable, one-by-one                     
	+- install the package in loop iteration                                      
HINT:                                                                             
+- use file tests                                                                 
+- use read builtin with while loop                                               
+- use apt to install packages. this needs sudo access  
```

**Solution**
---------------

```
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
```

# Slide 6

```
Enhance ~/bin/setup.sh to:                                                         
..........................                                                         

Add Users                                                                          

+- Create a simple script that                                                    
	+- checks if ~/data/users.list file exists                                    
	+- read ~/data/users.list file                                                
	+- store each user name in a loop variable, one-by-one                        
	+- create user                                                                

Enhance script                                                                     

+- Ask user for the name of the file on program start                             
+- Ensure current user has sudo rights at the start                              
+- Verify user does not exist already, before creation                            
+- If program fails, return with proper exit code                                 
+- Show final stauts of the packages from the list         
```

**Solution**
---------------

```
tmp=$(find ~/data -type f -name users.list)
if [[ -z $tmp ]]; then
        echo "users.list not found"
        exit
fi
echo $tmp
while IFS= read -r line; do
	flag=$(grep -c '^$line' /etc/passwd)
	if [[ $flag -ne 0 ]]
       	then
		echo $line' exists'
	else
		useradd -m $line
	fi
done < $tmp
```

# Slide 7

```
Enhance ~/bin/setup.sh to:                                                         
..........................   

Add help option            

+- Check if firt argument is help                                                 
+- if first agument is help                                                       
	+- show message help for my_program                                           

HINT :                                                                             

+- Use positional parameters to scripts                                           
+- Use special variable for scriptname to replace my_program                      
+- Use bash if consruct to check argument value                                   
```

**Solution**
---------------
```
if [[ $1 == "help" ]]; then
	echo "Help for "$0
	echo "Script that adds users and packages according to data folder"
fi
```
