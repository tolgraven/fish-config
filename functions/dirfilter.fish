function dirfilter --description 'use in prompt_long_pwd with sed, arg1 dir arg2 shortento'
	echo -n -s "-e \"s|^$argv[1]|$argv[2]|\""
end
