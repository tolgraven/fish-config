function repairpermissions
	itermprofileswitch "sudo /usr/libexec/repair_packages --verify --standard-pkgs / | ccze -A" TINY
    echo \n"changing back /usr/local..."\n
    spin "sudo chown -R (whoami) /usr/local/"
end
