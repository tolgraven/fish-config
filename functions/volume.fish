function volume --description 'get/set audio volume' --argument newvolume printnew
	if test -z "$newvolume" #"$argv"
        osascript -e "output volume of (get volume settings)" | grep -o --color=never "[0-9][0-9]*[0-9]" #getvolume
    else
        #set curr (volume) #(getvolume)
        set transform (math -s1 "$newvolume * 0.07")
        debug "newvolume %s transform %s" $newvolume $transform
        osascript -e "set volume $transform"
        not test -z "$printnew"
        and echo (volume) #"Volume:" $curr "->" (getvolume)
    end
end
