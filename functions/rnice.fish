function rnice --description 'because renice is in sudoers' --argument value process
sudo -n renice $value -p (pgrep $process) #%$process #>&- ^&-
end
