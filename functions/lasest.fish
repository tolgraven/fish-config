function lasest
	set output (lasr)

    echo -s -n $output\n | ack --nocolor --no-smart-case MB
    echo -s -n $output\n | ack --nocolor --no-smart-case GB
    echo -s -n $output\n | ack --nocolor --no-smart-case TB
end
