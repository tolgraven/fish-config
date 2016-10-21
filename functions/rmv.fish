function rmv --description 'mv with rsync'
	rsync $rsyncopts --remove-sent-files $argv
end
