function compsave --description 'Save the current definition of all specified completions to file'
	if count $argv >/dev/null
		switch $argv[1]
			case -h --h --he --hel --help
				echo "compsave is balls good"; return 0
		end
	else;		printf (_ "%s: Expected function name\n") compsave; return 1
	end

	set -l res 0
	set -l configdir ~/.config
	set -q XDG_CONFIG_HOME;	and set configdir $XDG_CONFIG_HOME

	for i in $configdir $configdir/fish $configdir/fish/completions
		test -d $i
		or if not command mkdir $i >/dev/null
				printf (_ "%s: Can't find or create config dir\n") compsave
				return 1
		end
	end

	for i in $argv
		if type -q -- $i
			#functions -- $i
			# SOME BADMAN TING > $configdir/fish/completions/$i.fish
		else
			printf (_ "%s: Unknown completion '%s'\n") compsave $i
			set res 1
		end
	end

	return $res
end
