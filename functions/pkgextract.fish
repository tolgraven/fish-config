function pkgextract
	pkgutil --expand $argv[1] (extname --reverse $argv[1])/
end
