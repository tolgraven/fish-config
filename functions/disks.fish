function disks
	type -q dfc
    and set cmd "dfc -s -w -c always -u g -q name | cgrep -v devfs"
    or begin
        type -q grc
        and set cmd "grc --colour=on df -Phl $argv" # P posix no inode, h human, l local only
        or set cmd "df -Phl $argv"
    end

    #echo (eval $cmd)[1]
    set output (eval $cmd | string replace "/Volumes/" "/V/" | string replace "$HOME" "~") #| sort | grep -v "Filesystem"
    echo $output[1]
    for i in (seq 2 (math (count $output)-1))
        set line (string split "/" $output[$i])
        echo -n -s $line[1]/$line[2]
        echo -s /$line[3..-1]
    end
    echo $output[-1]
    #set output (eval $cmd | sort | grep -v "Filesystem")
    #for line in $output; set volume (echo "/Volumes/"(string split "/Volumes/" $line)[-1] | grep --color=never -v "disk0s2"); echo $volume; end
    # | grep --color=always -v "Recovery" | grep --color=always -v "/Users" | string replace "/Volumes/" "/V/  " #"(set_color white)/V/(set_color purple)" # no need greps with -l
end
