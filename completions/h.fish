function __complete_hs_modules
    set -q __complete_hs_modules
    or set -g __complete_hs_modules (hs 'hs.doc("hs")')
    set -l type module
    test (count $__complete_hs_modules) -gt 3
    and for line in $__complete_hs_modules[4..-1]
        set line (string trim -- "$line")
        if not test -z "$line"
set -l desc (h d.m cm w)        
    echo -s (string replace -- "hs." "" $line) \t $type
        else
            break
        end
    end
end
function __complete_hs_vars #check type and yeah etc
    echo butt
end
function __complete_hs_tab
    #    set -l input (commandline --current-token)
    set -l output (hs "for i, val in pairs(hs.completionsForInputString('$input')) do 
		 print(val .. '\t' .. '' .. '\n')
		-- print(val .. '\t' .. type(val) .. '\n')
		-- print(val .. '\t' .. d/(val)[1] .. '\n')
	end")
    not test -z "$output"
    and echo -ns $output\n
    or return 1
end
complete -xc h -n "string match -q -r -- '-m' (commandline)" -a '(__complete_hs_modules)'
complete -xc h -n "string match -q -r -- '-v' (commandline)" -a '(__complete_hs_vars)'
complete -xc h -n "not string match -q -r -- '-m' (commandline)" -a '(__complete_hs_tab)'
complete -xc h -n "not __complete_hs_tab" -a "no completions"
