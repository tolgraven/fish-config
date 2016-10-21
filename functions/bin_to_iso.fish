function bin_to_iso --description 'convert macbin to iso' --argument bin cue
	bchunk $bin $cue (extname --reverse $bin).iso
end
