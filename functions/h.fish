function h --description 'call hammerspoon real good' --argument module_or_global the_rest
	#do: auto-call inspect + some json coloring if no more args than module or whatever
    #also complete for module if entered...
    #allow to call functions etc without paranthesis so dont need to quote in fish

    #figure out if need . or :
    #basically need to look up the relevant function before actually calling, then can put everything coming into relevant paran
    #guess ground rules is there's a global hanging out that we can call hehe, otherwise yeah massive mess...
    #basically call inspect to check so like i(mi) is blablabla, i(fart) is nil so

    #START WITH COMPLETIONS THO. SUBMODULES, FUNCTIONS ETC... good thing to have
    #debug "hs "hs.$module_or_global(not test -z "$the_rest"; and echo ":$therest(0)")""
    hs "hs.inspect($module_or_global)" | cat

    #not test -z "$the_rest"
    #and set the_rest ":$the_rest(0)"
    #hs "hs.$module_or_global$the_rest" #if module...
    #hs "$module_or_global$the_rest" #if instanceated

    # ( (not test -z "$the_rest"; and echo ':'$therest(0) )" #(string escape "$argv[2..-1]")"
end
