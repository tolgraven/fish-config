function fish_prompt --description 'Write out the prompt'
  switch $USER
    case root toor
      if not set -q __tolprompt_color_cwd
        set -q fish_color_cwd_root
        and set -g __tolprompt_color_cwd (set_color $fish_color_cwd_root)
        or  set -g __tolprompt_color_cwd (set_color -o red)
      end
      set -g __tolprompt_suffix '#'
    case '*'
      set -q __tolprompt_color_cwd;     or set -g __tolprompt_color_cwd (set_color $fish_color_cwd)
      set -q fish_prompt_pwd_dir_length;or set -g fish_prompt_pwd_dir_length 	4
      set -q __tolprompt_suffix; 				or set -g __tolprompt_suffix 					'>'
  end
	# set -g __tolprompt_suffix ''
  set -q tolprompt_dircolors;   				or set -g tolprompt_dircolors 		"colorpwd"
  set -q tolprompt_dirtransform;  			or set -g tolprompt_dirtransform 	"__tol_prompt_pwd"

  if set -q tolprompt_powerline
    __tol_prompt_powerline $tolprompt_dircolors $tolprompt_dirtransform
  else
    set pwd_colors  (eval $tolprompt_dircolors "prompt_pwd")
    set pwd_short   (eval echo -n "$pwd_colors")
    set pwd_final   (eval $tolprompt_dirtransform \"$pwd_short\")

    set -g last_prompt (echo -n -s "$__tolprompt_color_cwd" "$pwd_final" (set_color normal) "$__tolprompt_suffix ")
    set -g last_prompt_length (string length -- (echo -n $last_prompt | strip_ansi_color))

    echo -n $last_prompt
  end
end

function __tol_prompt_pwd --description 'Transform pwd for tolprompt' -a origpwd
  not test -z $origpwd
  and set -l tolpwd $origpwd; or return 1   #should be sourcing like a .config/tolpromptrc for below..
  set -q tolprompt_pwd_replacethis;   or set -U tolprompt_pwd_replacethis \
  '~' private priv System Syst Library Libr Applications Appl Downloads Contents Cont/ \
  Resources Reso/ App-Resources "Google Drive" Goog/Mack Volumes Volu/ Docu \
  homebrew-cask/Caskroom homebrew-cask/Caskroom home/Caskroom opt/home/Cask "Application Support"

  set -q tolprompt_pwd_replacewith;   or set -U tolprompt_pwd_replacewith \
  '~' '' '' S S L L A A Down C C/ R R/ A-R Drive ln V V/ Docs hb-c/C hb-c/C hb-c/C opt/hb-c/C AS

  if type -q string
    for i in (seq 1 (count $tolprompt_pwd_replacethis)) 
      set tolpwd (string replace -- $tolprompt_pwd_replacethis[$i] $tolprompt_pwd_replacewith[$i] $tolpwd)
    end  # needs to ignore the ((color codes to transform ie. Goog/Mack post color...
  else # pre 2.3
    set tolpwd "echo $tolpwd | sed \
    -e 's|^$HOME|~|' -e 's|^/private||' -e 's|^/priv||' -e 's|^/System|/S|' \
    -e 's|^/Syst/Library|/S/L|' -e 's|^/Syst/Libr|/S/L|' -e 's|^/Library|/L|' -e 's|^/Libr|/L|' \
    -e 's|^/Applications|/A|' -e 's|^/Appl|/A|' -e 's|^~/Library|~/L|' -e 's|^~/Downloads|~/Down|' \
    -e 's|^~/Documents|~/Docs|' -e 's|^~/Google Drive/Mackup|~/.ln|' -e 's|^/Volumes|/V|' \
    -e 's|^/opt/homebrew-cask/Caskroom|/opt/hb-c/C|' -e 's|^/usr/local|/usr/l|' \
    -e 's|^/Application Support|/AS|' "
    eval "$tolpwd"
    return 0
  end #;  debug $tolpwd 
  echo -n -s $tolpwd
end

function __tol_prompt_powerline -d "try make a powerline, no good" -a dircolors dirtransform
    set levels (eval $dircolors "prompt_pwd" "split_output")
    set -l colors; set -l text; set -l fulltext
    
    for i in (seq 1 (count $levels))
      set colors[$i] (string split -- " " $levels[$i])[1]
      set text[$i] (string split --max=1 -- " " $levels[$i])[2]
      set fulltext (echo -s -n "$fulltext" $text[$i]/)
    end
    
    set fulltext (eval $dirtransform $fulltext)

    set text (string split -- '/' $fulltext)[-1..1]
    set colors $colors[-1..1]

    set -l startindex 1;  set -l labeloffset 0
    if pwd_is_home
      set startindex 2; 	set labeloffset -1
    end
    for i in (seq $startindex (count $levels))
      segment black $colors[ (math $i+$labeloffset) ] $text[$i]
    end;  segment_close
end
