function replace --description replace\ \"from\"\ \"to\"\ in\ \"\\\$var\" --no-scope-shadowing --argument from to var extraarg
	# dunno why this isn't working... :( would be nice. but maybe just alias all string subfunctions to their respective names? 
    set $var (string replace --all $extraarg '$from' '$to' $$var)
end
