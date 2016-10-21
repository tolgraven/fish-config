function pbsort
	pbpaste | sort | uniq | strip_empty_lines | pbcopy
end
