function mkcd --description 'mkdir and cd'
	command mkdir $argv
    if test $status = 0
        switch $argv[-1]
            case '-*'

            case '*'
                cd $argv[-1]
                return
        end
    end
    and echo (pwd)
end
