function rsync_newer --description 'update all newer files' --argument from to
	rsync -v $rsyncopts --update --recursive
end
