function mountnfs --argument hostloc mountpoint
	#sudo 
    mount -t nfs -o $nfssettings $hostloc $mountpoint
    or sudo mount -t nfs -o $nfssettings $hostloc $mountpoint
end
