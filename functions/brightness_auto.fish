function brightness_auto --argument newbrightness
	test $brightness_automode = true
    and brightness_ramp $newbrightness
end
