function chrome_recover_tabs
pkill -9 Google\ Chrome
pushd ~/Library/Application\ Support/Google/Chrome/Default
mv Current\ Session Current\ Session_old
mv Current\ Tabs Current\ Tabs_old
cp Last\ Session Current\ Session
cp Last\ Tabs Current\ Tabs
popd
end
