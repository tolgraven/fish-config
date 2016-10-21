function bindcat --description 'show key bindings' --argument grepfor
	test -z "$grepfor"
    and set grepfor ""
    bind -k | sort --ignore-case | fish_indent --ansi | cgrep $grepfor
end
