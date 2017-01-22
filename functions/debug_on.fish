function debug_on --argument level
    test -z "$level"
    and set -g fish_debug '*'
    or set -g fish_debug "$argv"
end
