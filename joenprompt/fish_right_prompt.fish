function fish_right_prompt --description 'Write out the right prompt'
	set stat $status
	set -g __tolprompt_sec_or_stat (
		if 			test $stat -eq 0;		echo -s (set_color white) (date "+%S")
		else if test $stat -lt 10;	echo -s (set_color $fish_color_error) 0 $stat
		else if test $stat -lt 100;	echo -s (set_color $fish_color_error) $stat
		else; 											echo -s (set_color -o $fish_color_error) (tput smso) (string sub -s 2 $stat)
		end)
	set -q __fish_prompt_hostname; 			or set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
	set -q __tolprompt_charging_symbol; or set -g __tolprompt_charging_symbol '⚡'
	set -q __tolprompt_battery_symbol; 	or set -g __tolprompt_battery_symbol '▮' # '▯'
	set -q __tolprompt_docker_symbol; 	or set -g __tolprompt_docker_symbol ''
	set -e __tolprompt_extra #clear each time bc got multiple stuff adding itself...
	set -q __tolprompt_icon
	or set -g __tolprompt_icon '' 		#(imgcat ~/.config/fish/joenprompt/com.apple.macpro-cylinder_16x16x32.png)
	switch $USER
		case root toor;			set -g __tolprompt_color_user (set_color -o red) (tput smso)
		case '*tolgraven';	set -g __tolprompt_color_user (set_color -o blue)
		case '*';						set -g __tolprompt_color_user (set_color -o purple)
	end
	switch $__fish_prompt_hostname
		case absurd; 				set -g __tolprompt_color_host (set_color B8E6E6)
		 		 set -q __tolprompt_extra
		 	or set -g __tolprompt_extra (set_color -b black)"$__tolprompt_icon"  #"(imgcat ~/.config/fish/joenprompt/com.apple.macpro-cylinder_16x16x32.png)"
		case thenewpro;			set -g __tolprompt_color_host (set_color 009eff)
			set -g __tolprompt_extra (
        type -q battery
				and battery.info.update 
				not test -z $BATTERY_SLOTS
        and switch $BATTERY_SLOTS
					case (seq 0 2); echo (set_color -o red)
					case 3 4;				echo (set_color -o yellow)
					case '*';				echo (set_color green)
				end; 	set -q BATTERY_IS_PLUGGED 
					and echo $__tolprompt_charging_symbol
					or 	echo $__tolprompt_battery_symbol
			)
		case YE-OLDE-PRO;		set -g __tolprompt_color_host (set_color DC781C)
		case '*';						set -g __tolprompt_color_host (set_color -o red)
	end  # ---USER HOST--- part

	type -q debug; and set -q fish_debug
	and set -g __tolprompt_extra (segment_right black brred 
																for token in $fish_debug; segment black yellow $token; end 
																segment black brred 'debug'; segment_close; tput cub 1) 
			#echo -s (set_color -b brred) 'debug>' $fish_debug (set_color normal) ) $__tolprompt_extra
			# segment_right black brred 'debug'; segment black brred; segment_right black red $fish_debug; segment blue red ""; segment_close )
	echo -n -s $__tolprompt_extra "$__tolprompt_color_user" "$USER" "$__tolprompt_color_host" "$__fish_prompt_hostname" (set_color normal) 

	set -g __tolprompt_hourmin_str (set_color normal) (date "+%H") (set_color white) (date "+%M")
	set -g __tolprompt_hourmin_or_cmddur (set -q CMD_DURATION; and set -g dur $CMD_DURATION
		and type -q string 	
		and if 		test $dur -gt 1000
			if 			test $dur -lt 10000;		echo -s (set_color green) $dur 												# 9999 ms
			else if test $dur -lt 100000; 	echo -s (set_color yellow) (string sub -l 4 $dur)			# 99 s
			else if test $dur -lt 1000000; 	echo -s (set_color brred) (string sub -l 3 $dur) "s"	# 999 s = 16.7 m
			else if test $dur -lt 6000000; 	echo -s (set_color brred) (math $dur/60000) " m" 			# 99 m so pad		
			else if test $dur -lt 60000000; echo -s (set_color red) (math $dur/60000) "m" 				# 59 999 s = 999 m
			end;					else;							echo -s $__tolprompt_hourmin_str
		end; 													 or echo -s $__tolprompt_hourmin_str
	) # ---TIME / CMDDUR / STATUS--- part
	echo -n -s $__tolprompt_hourmin_or_cmddur $__tolprompt_sec_or_stat (set_color normal)  # (eval $__tolprompt_extra)
  ### TODO: SET COLORS FOR HOURS/MINS like 0-5 = shaders of blue, 06-11 yellow going on orange etc?
end
