function fis
	fisher search $argv --long | egrep --color=always -v 'prompt|theme'
end
