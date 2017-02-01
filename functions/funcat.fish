function funcat --description 'cat a function, with fun colors'
isatty 1
and status is-interactive
and set -l color "--ansi"
functions $argv | fish_indent $color
end
