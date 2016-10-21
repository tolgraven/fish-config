function hilight --description 'highlights matches, passing through all text'
	ack --color --color-match=blue --passthru --ignore-case -- $argv
    #grep -i --color=always --extended-regexp "$argv|"
end
