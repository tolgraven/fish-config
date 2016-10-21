function search-here
	mdfind -name "$argv" -onlyin ./ | grep -i "$argv"
end
