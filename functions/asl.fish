function asl
	itermprofileswitch "sudo vim /etc/asl.conf" vim $argv
    and sudo killall -HUP syslogd
end
