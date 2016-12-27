function hilight --description 'highlights matches, passing through all text'
	ack --color --color-match=blue --passthru --ignore-case -- $argv
    #grep -i --color=always --extended-regexp "$argv|"
    #string replace #wouldnt help restoring color cause dunno what to restore to ugh
end
