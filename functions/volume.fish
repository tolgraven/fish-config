function volume
	test -z $argv
    and getvolume
    or begin
        set curr (getvolume)
        set transform (math "$argv * 0.07")
        osascript -e "set volume $transform"
        echo "Volume:" $curr "->" (getvolume)
    end
end
