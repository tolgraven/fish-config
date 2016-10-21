function glances
	set -l args --process-short-name --hide-kernel-threads --fs-free-space
    #set -l args "--disable-quicklook --disable-cpu --disable-mem --disable-swap --disable-load --disable-hddtemp --disable-raid --disable-top --disable-process --process-short-name --hide-kernel-threads --fs-free-space"
    command glances --config ~/.config/glances/glances.conf $args $argv
end
