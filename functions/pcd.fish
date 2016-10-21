function pcd --description 'parallel cd'
	if test (count $argv) -eq 2
        builtin cd (echo $PWD|sed -e "s/$argv[1]/$argv[2]/")
    else
        builtin cd $argv
    end
end
