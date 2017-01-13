function path_colorize -d "colorize path with tags and rules" -a path
	#like colorpwd but generic (can run for files in sfz and stuff)

	set path (string replace -- '~' "$HOME" $path | string trim -r -c '/') #expand user, remove trailing slash
 	set path_split (string split -- '/' $path)[2..-1] 

	debug "$path"
	debug "$path_split"

	set path_split_each_proper_path
	set j 1
  for i in (seq (math (count $path_split)-1) 0) # seqs backwards from highest to lowest
		not test -z "$path"
		and string match -q -- '*/*' $path
		and set path_split_each_proper_path[$j] (string split --right --max $i -- '/' $path)[1]
		set j (math "$j+1")
  end

	# debug "$path_split_each_proper_path"

	set label_per_level
	set cmd_per_level
	for i in (seq 1 (count $path_split_each_proper_path))
			set label #dont forget to reset when checking for zero later lol
			switch $path_split_each_proper_path[$i]
					case bin exec "*.app" Applications MacOS
							set label brred
					case "*lib" "lib*" src include headers node python
							set label purple
					case "*.vst" "*.component" "ableton*"
							set label green
			end

			test -z "$label"
			and test -r $path_split_each_proper_path[$i]
			and set label (get_label $path_split_each_proper_path[$i] ^&-)
			test (count $label) -eq 1
			or set label "None"
			switch "$label"
					case 'None'; set label normal
					case 'Gray'; set label black
					case 'Orange'; set label brred
			end
			set label_per_level[$i] $label
			set cmd_per_level[$i] "(set_color $label_per_level[$i])"
	end

	debug "$label_per_level"
	debug "$cmd_per_level"

	for i in (seq 1 (count $path_split)) 
		set post '/' 		# always, exceot last round...
		set pre "" 			# only first round, except if ~
		test $i -eq 1
		# and test "$offset" -eq 0
		and set pre '/'
		test $i -eq (count $path_split)
		and set post ""

		set label_cmd_with_split_cmd[$i] (echo -ns $cmd_per_level[$i] $pre "$path_split[$i]" $post)
	end
	
	# debug "$label_cmd_with_split_cmd"

	set label_cmd_with_split_cmdstr
	for part in $label_cmd_with_split_cmd # put everything back together
			set label_cmd_with_split_cmdstr (echo -s -n "$label_cmd_with_split_cmdstr" "$part")
	end

	# debug "$label_cmd_with_split_cmdstr"

	eval echo -n "$label_cmd_with_split_cmdstr"


end
