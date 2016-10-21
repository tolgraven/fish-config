function sudopastetofile --description 'pbpaste >> file'
	pbpaste | sudo tee -a $argv
end
