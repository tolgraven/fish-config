function arrcat --description 'echo array with line breaks'
#echo -ns $argv\n
if string match -q -- '$*' $argv
string match '*' $argv
else if set -q $argv
string match '*' $$argv
end
end
