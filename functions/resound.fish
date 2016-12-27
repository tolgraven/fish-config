function resound
	#begin; audio -n
    #end
    #SwitchAudioSource 
    #or 

    set -l device (audio -c)
    audio "Pass-Thru"
    spin "sleep 0.2"
    audio -s "$device"
    #sudo pkill coreaudiod
end
