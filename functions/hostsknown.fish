function hostsknown
arp -a | hide '(' ')' 'at ' 'on ' 'ifscope ' | column -t | highlight | grep -v \? | string replace '[ethernet]' 'eth' | string replace 'permanent' 'p' #without grepv get spill from eg mass pings etc
end
