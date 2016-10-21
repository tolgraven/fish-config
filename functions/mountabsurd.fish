function mountabsurd
	#sudo 
    mount -t nfs -o $nfssettings absurd:/Users/tolgraven ~/mnt/absurd-perma/ $argv
    or mount -t nfs -o $nfssettings absurd.local:/Users/tolgraven ~/mnt/absurd-perma/ $argv
end
