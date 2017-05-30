function mvlatest --description 'move latest bunch of files from dir' --argument dir num_or_mins todir
not test -d "$dir"
and return 1
test -z "$todir"
and set todir $PWD
test -z "$num_or_mins"
and set num_or_mins 15m #minutes
switch $num_or_mins
case '*m' '*s' '*h'
# get files from timeframe
set -l mins (string match -r -- '\d*' $num_or_mins)
set hits (gfind $dir -mindepth 1 -maxdepth 1 -mmin -$mins)
echo -ns $hits\n
mv $hits $todir/

#echo $hits\n
case '*'
# just get x latest files
set -l index "-$num_or_mins"
set files (ls -t $dir)
set hits $files[1..$index] #vars dont work for neg indexes I guess
#set -l count $num_or_mins
#for i in (seq )
echo $hits\n
end
end
