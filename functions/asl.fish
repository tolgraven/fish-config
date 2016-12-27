function asl
	#itermprofileswitch "sudo vim /etc/asl.conf" vim $argv
    vim /etc/asl.conf $argv
    and sudo killall -HUP syslogd
end
