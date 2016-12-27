function mediainfo
	if string match -r -q -- "-" "$argv" #got flags
        command mediainfo $argv
        return
    end

    for file in $argv
        set output (command mediainfo $file | strip_empty_lines | grep ':' | grep -v "Format")

        set uniq
        for line in $output
            not contains -- $line $uniq
            and set uniq $uniq $line
        end

        set print $print (imgcat -t $file) $uniq \  #need last one or dont get them seperated. \n becomes its own element with newlines as content = double instead...
        echo -s (imgcat -t $file) \n (echo -ns $uniq\n | highlight)\n
    end

    #echo -ns $print\n #| highlight
end
