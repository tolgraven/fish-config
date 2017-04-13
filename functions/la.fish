function la --description 'List contents of directory, including hidden files in directory using long format'
set -U tols_filtered_files .DS_Store .Trash .Trashes .DocumentRevisions-V100 .PKInstallSandboxManager .Spotlight-V100 .TemporaryItems .Trashes .com.apple.timemachine .fseventsd .localized \$RECYCLE.BIN .IABootFiles .IAProductInfo
set -g tols_autolabeled_files "Green mp3 wav aif flac asd alp maxpat fxb vst component amdx" "Red zip rar 7z dmg" #etc
if not type -q grc
ls -lAhG $argv | for filter in $filters
grep --color=always -v $filter
end
return
end #TODO: size useless f dirs/count f nondirs so share col. +for /Volumes w drive icos /Icon support, plus size/used
set dirname (pwd)
or return $status
test (count $argv) -gt 0 #and if test -d $dirname/$argv[-1]; #set dirname $dirname/$argv[-1]
and if test -d (set dirname $dirname/$argv[1]; echo $dirname)
set -e argv[-1]
else if test -d $argv[-1]
or test -r $argv[1] #pass through also if a file so doesn't grab entire dir...
set dirname $argv[-1]
and set -e argv[-1]
end
test (count $argv) -gt 0 # after presumably unsetting dirr part
and set opts $argv
set output (grc -es --colour=on ls -lAhG $opts $dirname)
test (count $output) -gt 1
and set firstline $output[1]
and set output $output[2..-1]
set items (command ls -A $dirname)
for filter in $tols_filtered_files
set items (echo -s -n $items\n | grep --color=always -v $filter)
set output (echo -s -n $output\n | grep --color=always -v $filter)
end
set output (__tol_la_text_replacements "$output"\n)
test (count $items) -gt 0
and test (count $items) -eq (count $output)
and for i in (seq 1 (count $items))
set fullpath $dirname/"$items[$i]"
test -d "$fullpath"
and test -f "$fullpath"
and set label (get_label "$fullpath" terminal ^&- | string replace 'None' 'normal') #absolutely should parallelize this! would be hella faster...
or continue # lil bit of optimization for now, only checks dirs?

test $label = 'normal'
and switch $items[$i]
case bin sbin exec Applications MacOS
set label "brred"
case "*lib" "lib*" src include headers "node*" python "*.git*" "function*"
set label "purple"
case "share" "man"
set label "yellow"
case "*.vst" "*.component" "ableton*"
set label "green"
end
set relevantpart (string split -r -m 2 -- . "$items[$i]")[1] #test -z "$relevantpart" #and set relevantpart (string sub -s 2 -- "$items[$i]") #reset filepart to entire file if dotfile
or set relevantpart (string sub -s 2 -- "$items[$i]") #reset filepart to entire file if dotfile
set output[$i] (string replace -- "$relevantpart" (set_color $label)"$relevantpart"(set_color normal) "$output[$i]" ^&-) ^&-
end
string replace -- '>' (set_color -o red)'>'(set_color grey) $output # symlinks
end
