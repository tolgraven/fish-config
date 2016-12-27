function hostsknown
	arp -a | hide '(' ')' 'at ' 'on ' 'ifscope ' | column -t | highlight | grep -v \? #without grepv get spill from eg mass pings etc
end
