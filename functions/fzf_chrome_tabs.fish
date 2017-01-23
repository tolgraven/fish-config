function fzf_chrome_tabs
#bash ~/.config/fish/functions/fzf-chrome-cli.bash $argv
#set -l browser_name "Google Chrome"
set -l browser_name "Google Chrome"
set -l browser_cli "chrome-cli"
if not type -q $browser_cli
or not type -q fzf
return 1
end

#eval $browser_cli 
chrome-cli list tabs | string replace --all \' '' | highlight | fzf -1 --prompt=" Tab name> " | string match -r '^.\d+.' | string match -r '\d+' | read --array tab_ids
#| command grep -Eo '^.\d+.' | command grep -Eo '\d+' #| read --array tab_ids
echo $tab_ids

#activate window
chrome-cli activate -t $tab_ids
osascript -e "tell application \"$browser_name\" to activate"
end
