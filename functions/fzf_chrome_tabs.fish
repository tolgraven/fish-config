function fzf_chrome_tabs
	#bash ~/.config/fish/functions/fzf-chrome-cli.bash $argv
    set -l browser_name "Google Chrome"
    set -l browser_cli "chrome-cli"
    if not type -q $browser_cli
        or not type -q fzf
        return 1
    end

    #eval $browser_cli 
    chrome-cli list tabs | fzf -1 --prompt="Tab name> " | grep -Eo '^.\d+.' | grep -Eo '\d+' #| read --array tab_ids
    echo $tab_ids

    #activate window
    osascript -e "tell application '$browser_name' to activate"
end
