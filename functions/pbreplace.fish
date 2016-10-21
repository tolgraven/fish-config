function pbreplace --description 'find and replace in clipboard' --argument find replace
	pbpaste | sed "s/$find/$replace/g" | pbcopy #read -l clippy
    pbpaste
    #test (count $clippy) -gt 1
    #and set clippy $clippy[1..-2]
    #and echo -ns $clippy[1..-2]\n | pbcopy
end
