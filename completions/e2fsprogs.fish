function __fish_diskutil_devices
    set -l mountpoints /dev/disk*
    set -l desc (for disk in $mountpoints 
                   echo (echo (diskutil info $disk)[6] | string replace "Volume Name:" "" | \
                    string trim | string replace "Not applicable (no file system)" 'N/A')[-1] 
                end)
    #printf '%s\t%s\n' $mountpoints $desc
    for i in (seq (count $mountpoints)) 
      echo -n -s $mountpoints[$i] \t $desc[$i] \n
    end
end

function __fish_diskutil_mounted_volumes
    for line in (df -Phl | grep -v "Mounted on") 
      echo -n -s (echo $line | string split "  ")[1] \t (echo $line | string split "  ")[-1] \n
    end
    #set -l mountpoints /Volumes/*; printf '%s\n' $mountpoints
end

complete -xc e2fsprogs -n "__fish_use_subcommand" -a "echo (command ls (brew --prefix e2fsprogs)/sbin/)" 
complete -xc e2fsprogs -n "not __fish_use_subcommand" -a '(__fish_diskutil_mounted_volumes)'  #'(__fish_diskutil_devices)'