function xml_indent_color
	xmlstarlet format --indent-spaces 2 $argv | pygmentize
end
