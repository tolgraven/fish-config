function fish_right_prompt --description 'Write out the right prompt'

	set -g __tolprompt_status $status

	set -g __tolprompt_sec_or_stat (
		if 			test $__tolprompt_status -eq 0;		echo -s (set_color white) (date "+%S")
		else if test $__tolprompt_status -lt 10;	echo -s (set_color $fish_color_error) 0 $__tolprompt_status
		else if test $__tolprompt_status -lt 100;	echo -s (set_color $fish_color_error) $__tolprompt_status
		else; 											echo -s (set_color -o $fish_color_error) (tput smso) (string sub -s 2 $__tolprompt_status)
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
	or set -g __tolprompt_extra (bobthefish_part)

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


### bobthefish steal yo
# source ./bobthefish_prompt.fish
source ~/.config/fish/tolprompt/bobthefish_prompt.fish

function bobthefish_part
  # Save the last status for later (do this before the `set` calls below)
  set -l last_status $__tolprompt_status

  # Powerline glyphs
  set -l __bobthefish_branch_glyph            \uE0A0
  set -l __bobthefish_right_black_arrow_glyph \uE0B0
  set -l __bobthefish_right_arrow_glyph       \uE0B1
  set -l __bobthefish_left_black_arrow_glyph  \uE0B2
  set -l __bobthefish_left_arrow_glyph        \uE0B3

  # Additional glyphs
  set -l __bobthefish_detached_glyph          \u27A6
  set -l __bobthefish_tag_glyph               \u2302
  set -l __bobthefish_nonzero_exit_glyph      '!'
  set -l __bobthefish_superuser_glyph         '$'
  set -l __bobthefish_bg_job_glyph            '%'
  set -l __bobthefish_hg_glyph                \u263F

  # Python glyphs
  set -l __bobthefish_superscript_glyph       \u00B9 \u00B2 \u00B3
  set -l __bobthefish_virtualenv_glyph        \u25F0
  set -l __bobthefish_pypy_glyph              \u1D56

  set -l __bobthefish_ruby_glyph              ''

  # Vagrant glyphs
  set -l __bobthefish_vagrant_running_glyph   \u2191 # ↑ 'running'
  set -l __bobthefish_vagrant_poweroff_glyph  \u2193 # ↓ 'poweroff'
  set -l __bobthefish_vagrant_aborted_glyph   \u2715 # ✕ 'aborted'
  set -l __bobthefish_vagrant_saved_glyph     \u21E1 # ⇡ 'saved'
  set -l __bobthefish_vagrant_stopping_glyph  \u21E3 # ⇣ 'stopping'
  set -l __bobthefish_vagrant_unknown_glyph   '!'    # strange cases

  # Disable Powerline fonts
  if [ "$theme_powerline_fonts" = "no" ]
    set __bobthefish_branch_glyph            \u2387
    set __bobthefish_right_black_arrow_glyph ''
    set __bobthefish_right_arrow_glyph       ''
    set __bobthefish_left_black_arrow_glyph  ''
    set __bobthefish_left_arrow_glyph        ''
  end

  # Use prettier Nerd Fonts glyphs
  if [ "$theme_nerd_fonts" = "yes" ]
    set __bobthefish_branch_glyph     \uF418
    set __bobthefish_detached_glyph   \uF417
    set __bobthefish_tag_glyph        \uF412

    set __bobthefish_virtualenv_glyph \uE73C #' '
    set __bobthefish_ruby_glyph       \uE791 #' '

    set __bobthefish_vagrant_running_glyph  \uF431 # ↑ 'running'
    set __bobthefish_vagrant_poweroff_glyph \uF433 # ↓ 'poweroff'
    set __bobthefish_vagrant_aborted_glyph  \uF468 # ✕ 'aborted'
    set __bobthefish_vagrant_unknown_glyph  \uF421 # strange cases
  end

	#colors - gruvbox
	#               light  medium  dark  darkest
	#               ------ ------ ------ -------
	set -l red      fb4934 cc241d
	set -l green    b8bb26 98971a
	set -l yellow   fabd2f d79921
	set -l aqua     8ec07c 689d6a
	set -l blue     83a598 458588
	set -l grey     cccccc 999999 333333
	set -l fg       fbf1c7 ebdbb2 d5c4a1 a89984
	set -l bg       504945 282828

	set -g __color_initial_segment_exit  $fg[1] $red[2] --bold
	set -g __color_initial_segment_su    $fg[1] $green[2] --bold
	set -g __color_initial_segment_jobs  $fg[1] $aqua[2] --bold

	set -g __color_path                  $bg[1] $fg[2]
	set -g __color_path_basename         $bg[1] $fg[2] --bold
	set -g __color_path_nowrite          $red[1] $fg[2]
	set -g __color_path_nowrite_basename $red[1] $fg[2] --bold

	set -g __color_repo                  $green[2] $bg[1]
	set -g __color_repo_work_tree        $green[2] $fg[2] --bold
	set -g __color_repo_dirty            $red[2] $fg[2]
	set -g __color_repo_staged           $yellow[1] $bg[1]

	set -g __color_vi_mode_default       $fg[4] $bg[2] --bold
	set -g __color_vi_mode_insert        $blue[1] $bg[2] --bold
	set -g __color_vi_mode_visual        $yellow[1] $bg[2] --bold

	set -g __color_vagrant               $blue[2] $fg[2] --bold
	set -g __color_username              $fg[3] $blue[2]
	set -g __color_rvm                   $red[2] $fg[2] --bold
	set -g __color_virtualfish           $blue[2] $fg[2] --bold

  set -l __bobthefish_current_bg #Start each line with a blank slate

  __bobthefish_maybe_display_colors

  __bobthefish_prompt_status $last_status
  __bobthefish_prompt_vi
  __bobthefish_prompt_vagrant
  __bobthefish_prompt_docker
  # __bobthefish_prompt_user
  __bobthefish_prompt_rubies
  __bobthefish_prompt_virtualfish


  set -l git_root (__bobthefish_git_project_dir)
  set -l hg_root  (__bobthefish_hg_project_dir)

  if [ "$git_root" -a "$hg_root" ]
    # only show the closest parent
    switch $git_root
      case $hg_root\*
        __bobthefish_prompt_git $git_root
      case \*
        __bobthefish_prompt_hg $hg_root
    end
  else if [ "$git_root" ]
    __bobthefish_prompt_git $git_root
  else if [ "$hg_root" ]
    __bobthefish_prompt_hg $hg_root
  else
    # __bobthefish_prompt_dir
  end

  # __bobthefish_finish_segments
end
