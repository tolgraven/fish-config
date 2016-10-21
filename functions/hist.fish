function hist --description 'color history search wow'
	#set lines (history $argv | fish_indent --ansi)
    #echo $lines\n #| cgrep $argv[-1]
    history "$argv" | fish_indent --ansi | cgrep "$argv[-1]"
end
