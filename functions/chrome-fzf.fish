function chrome-fzf
	set -l browser "Google Chrome"
    set -l cli "chrome-cli"
    type -q $cli
    and type -q fzf
    or return
    #well, need to extract just tab id from line and then url (third line) from response...
    set -l fzfopts "--multi" "--preview-window=down:10" #--preview='chrome-cli info -t {}'" 
    set -l grep "grep -Eo '^.\d+.' |grep -Eo '\d+'" #grabbed from other script dunno if work?
    set -l IFS \n
    chrome-cli list tabs -w 692 | fzf $fzfopts >~/.toltest #| read --array -l tabs  #multi doesnt seem to work unless write to file instead of read..
    set -l tabs (cat ~/.toltest)
    #set -l tabs $one $two $three
    count $tabs
    set -l ids (echo $tabs | eval $grep)
    debug $tabs $ids
    echo $tabs
    echo $ids
    for id in $ids
        echo $id
        #chrome-cli close -t $id
    end
end
