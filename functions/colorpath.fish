function colorpath --description 'Transform path with label/tag colors' --argument path #split_output text_no_eval
	type -q get_label #TODO: expand to use simple filter to color certain types of dirs
  and type -q hfsdata #more auto more bettter
	or return 1

	set pwd_full $path
	set pwd_short (gtest $pwdstyle -ef (pwd); and prompt_pwd) #; or begin; cd $pwdstyle; prompt_pwd;prevd; end)

	set -g pwd_full_split (string split -- '/' $pwd_full)[2..-1] ^&- #; or return 1
	set pwd_short_split (string split -- '/' $pwd_short)
	test (count $pwd_short_split) -gt 1
	and test -z "$pwd_short_split[1]"
	and set pwd_short_split $pwd_short_split[2..-1] ^&- #; or return 1

	set offset (math (count $pwd_full_split)-(count $pwd_short_split))

	set pwd_full_split_each_proper_path
	set j 1
	for i in (seq (math (count $pwd_full_split)-1) 0) # seqs backwards from highest to lowest
			not test -z "$pwd_full"
			and string match -q -- '*/*' $pwd_full
			and set pwd_full_split_each_proper_path[$j] (string split --right --max $i -- '/' $pwd_full)[1] #remember x splits means x+1 eventual parts, so is this right?
			set j (math "$j+1") # goes the opposite way. could subtract from count instead i guess?
	end

	set label_per_level
	set label_cmd_per_level
	for i in (seq 1 (count $pwd_full_split_each_proper_path))
			set label #dont forget to reset when checking for zero later lol
			switch $pwd_full_split_each_proper_path[$i]
					case bin exec "*.app" Applications MacOS
							set label brred
					case "*lib" "lib*" src include headers node python
							set label purple
					case "*.vst" "*.component" "ableton*"
							set label green
			end # quick test of concept will introduce arrays and a for loop for customization

			test -z "$label"
			and test -r $pwd_full_split_each_proper_path[$i]
			and set label (get_label $pwd_full_split_each_proper_path[$i] ^&-)
			test (count $label) -eq 1
			or set label "None"
			switch "$label" # replace w the two arrays label_colors and label_colors_fish...
					case 'None'
							set label normal
					case 'Gray'
							set label black
					case 'Orange'
							set label brred
			end
			set label_per_level[$i] $label
			set label_cmd_per_level[$i] "(set_color $label_per_level[$i])"
	end

	set label_cmd_with_split_cmd
	if test -z "$split_output"
			or test $split_output = "no"

			for i in (seq 1 (count $pwd_short_split) )
					set postslash '/' # always, exceot last round...
					set preslash "" # only first round, except if ~
					test $i -eq 1
					and test $offset -eq 0
					and set preslash '/'
					test $i -eq (count $pwd_short_split)
					and set postslash ""

					set label_cmd_with_split_cmd[$i] (echo -n -s \
				$label_cmd_per_level[ (math $i + $offset) ]  $preslash "$pwd_short_split[$i]" $postslash)
			end
	else
			for i in (seq 1 (count $pwd_short_split) )
					echo $label_per_level[ (math $i+$offset) ] $pwd_short_split[$i]
			end
			return 0
	end

	set label_cmd_with_split_cmdstr
	for part in $label_cmd_with_split_cmd # put everything back together
			set label_cmd_with_split_cmdstr (echo -s -n "$label_cmd_with_split_cmdstr" "$part")
	end
	echo -n "$label_cmd_with_split_cmdstr"
end
