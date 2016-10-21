function bind_key
	fish_key_reader | read -l newkey #only works if called directly, not from function. or at least not tolmenu...
    #set newkey (string replace "do something" "" $newkey)

    commandline -i $newkey
    commandline -f repaint
end
