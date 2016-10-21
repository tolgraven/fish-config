function locate
	command -s ccat > /dev/null
    and command locate $argv | ccat
    or command locate $argv
end
