function fzf
#24bit color workaround...
set -q fish_term24bit #need to flip off 24bit color because fzf bugs out...
and set -l had24color $fish_term24bit
and set fish_term24bit 0

command fzf $argv
set -q had24color
and set fish_term24bit $had24color
end
