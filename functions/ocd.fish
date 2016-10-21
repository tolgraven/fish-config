function ocd
	not test -z $argv[1]
    and if string match -- (extname $argv[1]) "cloudf"
        test -e $argv[1]
        and odrive sync $argv[1]
        and cd (extname --reverse $argv[1]) #(basename $argv[1] -s ".cloudf")

    else if test -d $argv[1]
        cd $argv[1]
    else
        return 1
    end
end
