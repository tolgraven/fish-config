function mountpro
	#sudo 
    mount -t nfs -o $nfssettings thenewpro.local:/Users/joentolgraven ~/mnt/new-perma/ $argv
end
