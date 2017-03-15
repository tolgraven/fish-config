function killed --description 'edit killring'
set -l cmdlines (commandline)
set -l pos (commandline --cursor)



commandline -- $cmdlines
commandline --cursor $pos
commandline -f repaint
end
