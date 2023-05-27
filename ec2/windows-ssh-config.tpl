add-content -path c:/users/reaver/.ssh/config -value@'

Host ${hostname}
	HostName ${hostname}
	User ${user}
	IdentityFile ${identityfile}
'@