function sla
	for i in (search $argv[1])
        if not test -d $i
            #echo (tint: red (bold: la))
            echo (tint: green $i)
            eval (echo la $i)
        else
            #la $i/../
            set filename (string split / $i)[-1]
            #echo (tint: red (bold: la)) (tint: green $i/../)
            #echo $filename
            la -G $i/../ | grep --color=always $filename
            command tree -CuxhpA -L 3 --noreport --filelimit 8 $i
        end
        echo
    end
end
