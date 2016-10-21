function contall
	for app in $appstopause
        cont $app
        #and echo "resumed $app"
    end
    #open -a "Activity Monitor"
    pgrep Live
    and live
end
