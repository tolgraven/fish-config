function shere
	mdfind -name "$argv" -onlyin ./ | ccat | grep -i "$argv"
end
