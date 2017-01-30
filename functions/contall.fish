function contall
for app in $appstopause
rnice 0 $app
cont $app
#and echo "resumed $app"
end
#open -a "Activity Monitor"
pgrep Live
and live
end
