function files --description 'List (total) folder/file sizes, top level only' --argument adir
	set -l directory .

    test -z $adir
    and echo -s (tint: red (du -shx)) (tint: blue (pwd)/)
    or if test -d $adir
        set directory (dirname $adir) #(test (string sub -s -1 $adir) = /; 
        #          and string sub -l (math (string length $adir) -1) $adir; 
        #         or echo $adir) #remove trailing slash if present
        pushd (pwd)
        cd $directory
        echo -s (tint: red (du -shx (pwd)))
        popd
    end
    type -q ccat
    and set ccat "| command ccat"
    or set ccat ""

    set -l command "du -smx (find \"$directory\" -size +5M -maxdepth 1; find \"$directory\" -type d -maxdepth 1) ^ /dev/null | sort -n $ccat" # | ccat" #s summarize, x stay on filesystem, m mbsize

    functions -q spin
    and spin $command
    or eval $command
end
