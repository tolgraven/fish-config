function strip_every_other_line --argument file even
test -z "$file"
and return 1
if test "$even"
gsed -n '1~2!p' $file
else
gsed '1~2d' $file
end
end
