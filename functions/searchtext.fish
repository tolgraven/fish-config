function searchtext --description 'search recursively for text in files in current dir, or from path' --argument text dir
	test -z "$text"
    and return 1
    #test -z $dir
    #and set dir .

    set -l writedir (not test -z "$dir"; and echo $dir; or pwd) #(test $dir != .; and echo $dir; or pwd)
    set -l output (echo (set_color --bold brred)$text (set_color normal)"in dir" (set_color brblue)$writedir(set_color normal))
    #grep -i -H -Z -n -R --context=2 $text $dir ^&- | string replace "./" "" | ccat --color=always | cgrep --context=1 $text #| cgrep -v -- "--"
    set -l ackopts --ignore-case --recurse --follow #force color, nocase, context, follow...

    for hit in (ack $ackopts --files-with-matches $text $dir) #gives ful path if we give dir so dont need to specify it later..
        varadd output (echo (set_color normal) $hit)
        #varadd output (cat --force -n $dir/$hit | ack $ackopts --color --context=1 $text ^&-)
        varadd output (cat --force -n $hit | ack $ackopts --color --context=1 $text ^&-)
    end
    test (count $output) -gt 0
    or return 1
    #echo -ns $output\n
    #echo -ns (string trim --left --chars "   " -- $output)\n
    string replace '   ' '' -- $output | string replace '    ' '  ' #fix indentation a bit
    #grep -i -H -Z -n -R --context=2 (__tol_prepend_e_each_subgrep $text) $dir | ccat --color=always | cgrep (__tol_prepend_e_each_subgrep $text)
end
