function search
	mdfind -name "$argv" | grep -i "$argv"
end
