function cowrev
	cowsay $argv | revawk | tr '[[]()<>/\\]' '[][)(><\\/]'
end
