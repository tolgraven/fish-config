function pygmentize
set -l style gruvbox #update with bruvbox when it's ready
set -l format terminal256 #can get truecolor?
command pygmentize -f $format -P style=$style $argv
end
