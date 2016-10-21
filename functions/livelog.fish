function livelog
	pushd (pwd)
    set abledir ~/Library/Preferences/Ableton/
    cd $abledir(ls -t $abledir)[1]
    ctail Log.txt | command lnav #-t
    #command lnav Log.txt
    popd
    #ccat (cd ~/Library/Preferences/Ableton/; pwd; ls -t)[1+2]/Log.txt | lnav -t
end
