function nocat --description 'cat without empty lines' --argument file
	test -z $file
    and return 1
    set -l ext (extname $file)
    command cat $argv | strip_empty_lines | vimcat -c "set filetype=$ext"
end
