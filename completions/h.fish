function __complete_hs_modules
    set -q __complete_hs_modules
    or set -g __complete_hs_modules (hs 'hs.doc("hs")')
    set -l type module
    test (count $__complete_hs_modules) -gt 3
    and for line in $__complete_hs_modules[4..-1]
        set line (string trim -- "$line")
        if not test -z "$line"
            #        if not set -q oneblank
            echo -s (string replace -- "hs." "" $line) \t $type
        else if test -z "$line"
            break
            # set -q oneblank; and break #  set oneblank
            #            continue #    break
            #        else if test "$line" = '\[subitems\]' #string match -- '*[subitems]*' $line
            #            set -e oneblank # set type var
        end
    end
end

function __complete_hs_tab
  set -l input (commandline --current-token)
  # set -l output (hs "fishCompletion('$input')")
	# set -l output (hs "local tmp = ''
	# for i, val in pairs(hs.completionsForInputString('$input')) 
	# 	do tmp = tmp .. val .. '\t' .. '' .. '\n'
	# end
  # return tmp")
	set -l output (hs "for i, val in pairs(hs.completionsForInputString('$input')) do 
		print(val .. '\t' .. '' .. '\n')
	end")

	echo -ns $output\n
end
complete -xc h -n "string match -q -- '* -m *' (commandline)" -a '(__complete_hs_modules)'
complete -xc h -n "not string match -q -- '* -m *' (commandline)" -a '(__complete_hs_tab)'
