function speakers
	audioswitch -s "Balance"
    pgrep Audio\ Hijack
    and audiohijack toggle sonarworks-headphone-subpac-split
end
