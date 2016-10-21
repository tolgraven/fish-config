function mountmain
	switch (host_info host)
        case "absurd"
            sudo mount -t nfs -o $nfssettings thenewpro.local:/Volumes/MAINMAIN /Volumes/MAINMAIN $argv
        case *
            sudo mount -t nfs -o $nfssettings absurd.local:/Volumes/MAINMAIN ~/mnt/MAINMAIN-perma/ $argv
    end
end
