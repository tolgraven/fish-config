function h --description 'call hammerspoon real good' --argument module_or_global the_rest
	#auto-call inspect if no more args than module or whatever
    #allow functions etc without paranthesis so dont need to quote in fish, figure out if need . or :
    #need to look up relevant func before calling, then can put everything into relevant paran
    #guess ground rules is there's a global hanging out that we can call
    #basically call inspect to check so like i(mi) is blablabla, i(fart) is nil so
    not string match -q 'd.*' -- $module_or_global
    and set -l cmd 'hs "hs.inspect($module_or_global)"'
    or set -l cmd 'hs $module_or_global'
    eval $cmd | string replace -a -- '\n' \n | string replace -a -- '\t' '' | strip_empty_lines | pygmentize -l lua | string replace -a -- ' * ' (set_color -b brred)'* '(set_color normal) | string replace -a -- 'Parameters:' (set_color --background green -o black)'Parameters:'(set_color normal) | string replace -a -- 'Returns:' (set_color -b yellow -o black)'Returns:'(set_color normal) | string replace -a -- 'Notes:' (set_color -b purple -o black)'Notes:'(set_color normal)

    #not test -z "$the_rest"; and set the_rest ":$the_rest(0)"
    #hs "hs.$module_or_global$the_rest" #if module...
    #hs "$module_or_global$the_rest" #if instanceated
    # ( (not test -z "$the_rest"; and echo ':'$therest(0) )" #(string escape "$argv[2..-1]")"
end
