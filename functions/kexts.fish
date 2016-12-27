function kexts --description 'list loaded kexts. default only non-apple' --argument type
	test -z "$type"
    and set type "user"
    switch $type
        case "user"
            #set cmd "kextstat -l | grep -v com.apple"
            set cmd "kextfind -loaded -report -no-header -b -V -print | grep -v com.apple"
        case "all"
            set cmd "kextfind -loaded -report -no-header -b -V -print" #"kextstat -l" #-l = no header
        case "apple"
            set cmd "kextfind -loaded -report -no-header -b -V -print | grep com.apple" #"kextstat -l | grep com.apple"
    end #columns: Index Refs Address  Size  Wired  Name (Version) UUID <Linked Against>
    set -l kextlist (eval $cmd)
    set -l seq (seq 1 (count $kextlist))
    #for i in $seq
    #set output (string split "0x" (string trim $kextlist[$i]))[-1]
    #string sub -s 8 $output | string trim | read output #chop everything before bundle-id
    #set splitver (echo -s "<"(string split "<" $output)[-1]) #skip normally. breaks some anyways
    #set output (string split "<" $output)[1]
    #set output (string split " " $output)
    #set namecol[$i] (echo -n $output[1]) # | ccat)
    ##set vercol[$i] (echo -s (set_color brpurple) $output[2] #\t (set_color black) $output[3] \t (set_color red) $splitver (set_color normal)) #skip UUID and linked id thing cause meh
    #end
    for i in $seq
        set output (string split \t $kextlist[$i])
        set namecol[$i] $output[1]
        set vercol[$i] $output[2] #(echo -s (set_color brpurple) $output[2]) #move below

        string match -q -- '/Library/Extensions*' $output[3]
        and set output[3] \ \ $output[3]
        set pathcol[$i] (echo -n $output[3] | string replace "Library/Extensions" (set_color normal)"L"(set_color brred)"/E"(set_color normal)  | string replace "System" (set_color brred)"S"(set_color normal) | string replace "Contents" (set_color brred)"C"(set_color normal) | string replace "PlugIns" (set_color brblack)"P"(set_color normal)  | highlight)
    end
    set -l offset_vercol (strlen_longest $namecol\n) #len of name (bundleid)
    set -l offset_pathcol (math (strlen_longest $vercol\n) + $offset_vercol) #len of ver

    for i in $seq
        set outstr $outstr (echo -s (echo -ns $namecol[$i] | highlight) (echo -ns (tput hpa (math $offset_vercol + 0)) (set_color brpurple)$vercol[$i]) (echo -ns (tput hpa $offset_pathcol) $pathcol[$i]))
    end
    echo -ns $outstr\n | sort
end
