function funcmv --argument orig new
	funcopy $orig $new
    and funcrm $orig
    #and trash ~/.config/fish/functions/$orig.fish
end
