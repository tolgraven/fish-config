function colorpwd --description 'Transform fish prompt_pwd etc with label/tag colors' --argument pwdstyle split_output text_no_eval
	type -q get_label #TODO: expand to use simple filter to color certain types of dirs
    and type -q hfsdata #more auto more bettter
    or begin
        echo (prompt_pwd)
        #echoerr "brew install osxutils, or use other dircolors"
        return 1
    end

    if test -z "$text_no_eval"

        test -z "$pwdstyle"
        and set pwdstyle prompt_pwd

        set pwd_full (pwd)
        or set pwd_full $PWD
        test -z "$pwd_full"
        and begin
            echo '__no-dir__ '
            return 1
        end
        set pwd_short (eval $pwdstyle)
    else # if for diffrent dir than current
        test -z "$pwdstyle"
        and return 1
        set pwd_full $pwdstyle
        set pwd_short (gtest $pwdstyle -ef (pwd); and prompt_pwd) #; or begin; cd $pwdstyle; prompt_pwd;prevd; end)
        #test -z $pwd_short; and return 1
    end # debug "pwd_full is %s. pwd_short is %s" $pwd_full $pwd_short

    set -g pwd_full_split (string split -- '/' $pwd_full)[2..-1] ^&- #; or return 1
    set pwd_short_split (string split -- '/' $pwd_short)
    test (count $pwd_short_split) -gt 1
    and test -z "$pwd_short_split[1]"
    and set pwd_short_split $pwd_short_split[2..-1] ^&- #; or return 1

    # debug "pwd_full_split is %s. pwd_short_split is %s" $pwd_full_split $pwd_short_split
    set offset (math (count $pwd_full_split)-(count $pwd_short_split))

    set pwd_full_split_each_proper_path
    set j 1
    for i in (seq (math (count $pwd_full_split)-1) 0) # seqs backwards from highest to lowest
        not test -z "$pwd_full"
        and string match -q -- '*/*' $pwd_full
        and set pwd_full_split_each_proper_path[$j] (string split --right --max $i -- '/' $pwd_full)[1] #remember x splits means x+1 eventual parts, so is this right?
        set j (math "$j+1") # goes the opposite way. could subtract from count instead i guess?
    end
		
		set git_repo_dir (__bobthefish_git_project_dir)
		and set git_repo_index (math (count (string split -- '/' $git_repo_dir)) - 1)
		debug "git repo search result: index %s, dir %s" $git_repo_index $git_repo_dir

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

						set i_offset (math $i + $offset)
						set -q git_repo_index
						and test $i_offset -eq $git_repo_index
						and set -l git_on "(tput smso)"
						and set -l git_off "(tput rmso)"
						and debug "found git repo at index %s, offset %s, dir %s" $i $offset $pwd_full_split_each_proper_path[$i]

            set label_cmd_with_split_cmd[$i] (echo -ns \
			   $label_cmd_per_level[$i_offset] $preslash $git_on "$pwd_short_split[$i]" $git_off $postslash)

				 		set -e git_on #why does set -l persist across loops?
						set -e git_off
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
