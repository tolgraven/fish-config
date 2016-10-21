function headphones
	audioswitch -s "Soundflower (2ch)"
    pgrep Hijack >&-
    or open -a "Audio Hijack"
    #switch to space 1 seems that's required?
    open -a soundflowerbed
    reniceaudio
    audiohijack toggle sonarworks-headphone-subpac-split
end
