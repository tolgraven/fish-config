function ports --argument protocol
	test -z $protocol
    and set prot tcp
    or set prot $protocol
    netstat -tulanp $prot
end
