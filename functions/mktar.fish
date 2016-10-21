function mktar --description 'archive ur shit. if no target filename is used' --argument target source
	if test -z $source
        set source $target
        and set target $target.tar.gz
        tar czf $target $source
    else if test (extname $target) = "gz"
        tar czf $argv
    else
        tar cf $argv
    end
end
