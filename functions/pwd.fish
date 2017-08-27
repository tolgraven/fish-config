function pwd --description 'colored pwd if tty, else normal pwd'
if isatty 1
and status --is-interactive
and not status --is-command-substitution
and type -q cpwd
cpwd
else
command pwd
end
end
