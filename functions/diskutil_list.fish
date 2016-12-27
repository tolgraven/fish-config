function diskutil_list --argument listopt
	set -l devnum 0
    set -l linenum 1
    for line in (diskutil list)
        #set thirdcol (echo $line | cut -c34- | string trim)
        #test -z "$thirdcol"
        test -z (string sub --start 34 --quiet $line)
        and continue

        set part (string split ' ' $line)[-1]

        contains -- "--disks" $listopt >&- ^&-
        and set name ''
        or set name (echo $line | cut -c34-56 | string trim)

        test -n "$name"
        #or set name (string trim (set split (string split ":" -- (string match "*Device / Media Name:*" (diskutil info $part))); and echo $split[-1]))
        or string trim (string split ":" -- (string match "*Device / Media Name:*" (diskutil info)) $part )[-1] | read name

        set output $output $part\t$name
    end
    echo -ns $output\n
end
