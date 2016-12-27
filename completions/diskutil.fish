test -f $fish_complete_path[-2]/diskutil.fish
and source $fish_complete_path[-2]/diskutil.fish

function __fish_diskutil_devices
    set -l mountpoints #(ls /dev/disk*)
    set -l token (commandline --current-token) ^&-

    not string match -q -- "*disk*" $token
    #    and echo -ns $mountpoints\n
    and diskutil_list --disks
    and return

    #    echo "/dev/"(diskutil_list)\n
    diskutil_list
    and return

    set -l i 1
    set -l matches (string match -- "$token*" $mountpoints)
    for dev in $matches
        set info (diskutil info $dev)
        if string match -r -q '/dev/disk\ds\d*' $dev #volume 
            set vol[$i] (string replace 'Not applicable (no file system)' '' (string trim (string split ":" -- (string match "*Volume Name:*" $info))[-1]))
            #            test -z "$vol[$i]"
            #            and set vol[$i] 'EFI or sys'
            # debug "hit volume! %s" $i
        else #disk
            set vol[$i] (string trim (string split ":" -- (string match "*Device / Media Name:*" $info))[-1]) ^&-
            #            test -z "$vol[$i]"
            #            and set vol[$i] "NADA"
            # debug "hit disk! %s" $i
        end
        set size[$i] (string split '  ' (string split ' (' (string match "*Total Size:*" $info))[1])[-1] ^&-
        debug "dev: %s vol: %s size: %s" $dev $vol[$i] $size[$i]
        set i (math "$i+1")
    end
    # printf '%s\n' $mountpoints
    # printf "%s\t%s\n" $mountpoints $devnr
    for i in (seq 1 (count $matches) #(count $mountpoints))
        #        not test -z "$vol[$i]"
        #        and set vol[$i] "BULLSHIT" #test
        #        set matches[$i] "hubba"
        set out (echo -ns "$matches[$i]" (not test -z "$vol[$i]"; and echo -ns \t "$vol[$i]") #\n)
        # set out (echo -ns "$mountpoints[$i]" \t "NOPE" \n)
        debug "%s %s" $out $i
        echo -ns $out\n
    end
end

function __fish_diskutil_mounted_volumes
    set -l mountpoints /Volumes/*
    printf '%s\n' $mountpoints
end
