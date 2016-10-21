function ringtone --description 'create ringtone' --argument input output
	afconvert $input (extname --reverse $input).m4r -f m4af
end
