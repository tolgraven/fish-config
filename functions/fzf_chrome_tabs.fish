function fzf_chrome_tabs
#bash ~/.config/fish/functions/fzf-chrome-cli.bash $argv
#set -l browser_name "Google Chrome"
set -l browser_name "Google Chrome"
set -l browser_cli "chrome-cli"
not type -q $browser_cli
or not type -q fzf
and return 1


#eval $browser_cli 
set -l windows (chrome-cli list windows | string match -r '\d+') #get ids
parallel --seqreplace ,, -j (count $windows) "chrome-cli list tabs -w ,," ::: $windows
set -l hits (chrome-cli list tabs | string replace --all \' '')

echo -ns $hits\n | fzf -1 --prompt=" Tab name> " | string match -r '^.\d+.' | string match -r '\d+' | read --array tab_ids
#| command grep -Eo '^.\d+.' | command grep -Eo '\d+' #| read --array tab_ids
echo $tab_ids

#activate window
if test "$tab_ids"
chrome-cli activate -t $tab_ids
osascript -e "tell application \"$browser_name\" to activate"
end
end
