function uncompyledir --description 'decompile all pycs in current dir to current dir'
	for file in (ls)
        uncompyle2 -m --py --verify -o . $file
    end
end
