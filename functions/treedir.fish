function treedir --description 'runs tree on all subdirs'
for dir in (ls -A)
if test -d $dir
command tree -Cax -L 3 --filelimit 30 -d --noreport $argv $dir
continue

set -l hasdir
for child in (ls -A $dir)
test -d $child
and set hasdir true
and echo $child
end
not test -z "$hasdir"
and command tree -Cax -L 3 --filelimit 30 -d --noreport $argv
#or ls -A $dir
end
end
end
