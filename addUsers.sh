#!/bin/bash

path="/home/test/userAddScript/users.csv"

while IFS=";" read -r name password
do
	fname=$(echo $name | awk '{print($2)}')
	lname=$(echo $name | awk '{print($1)}')
	
	#echo -e "Vezetéknév:\t\t"$fname
	#echo -e "Keresztnév:\t\t"$lname
	lowerfname=$(echo $fname | tr '[:upper:]' '[:lower:]' | sed 'y/ÁÍÉÓÖŐÚÜŰáíéóöőúüű/aieooouuuaieooouuu/')
	lowerlname=$(echo $lname | tr '[:upper:]' '[:lower:]' | sed 'y/ÁÍÉÓÖŐÚÜŰáíéóöőúüű/aieooouuuaieooouuu/')
	funamecut=$(echo $lowerfname | cut -c1-3)
	lunamecut=$(echo $lowerlname | cut -c1-3)
	uname=$funamecut.$lunamecut
	echo -e "Generated username:\t$uname"
	echo "$uname:$password" | chpasswd
	sudo mkdir -p /home/$uname/ftp
	sudo chown $uname: /home/$uname/ftp
	sudo chmod -R 750 /home/$uname/ftp
	sudo echo $uname >> /etc/vsftpd.userlist

done < <(sed 1,1d $path)
