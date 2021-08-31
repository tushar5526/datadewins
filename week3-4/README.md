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

Solution:

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