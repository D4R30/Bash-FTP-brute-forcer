## Bash-FTP-brute-forcer
# FTP brute-forcer written in bash using ftp client.

Usage:

  	./FTPcracker IP USERNAME PASSWORD_LIST NumberOfProceses

  IP: The target's IP address.
  USERNAME: The target's login username.
  PASSWORD_LIST: Wordlist file address.
  NumberOfProcess: Number of process to generate for accelerating brute-force.(Enter 0 for none)

	Example:
		FTPcracker 192.168.1.1 admin pass_list.txt 5

It also accelerates the progress by making back-ground independent processes for each password.

Contact me: D4R30@protonmail.com
