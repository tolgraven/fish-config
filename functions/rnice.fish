function rnice --description 'because renice is in sudoers' --argument value process
	sudo -n renice $value -p %$process
end
