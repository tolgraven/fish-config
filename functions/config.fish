function config
	set -l config_path ~/.config/fish/conf.d/init_joen.config.fish

    if type -q vim
        vim $argv $config_path
        #itermprofileswitch vim vim "$argv ~/.config/fish/conf.d/init_joen.config.fish"
    else if type -q slap
        command slap --fileBrowser.width 0 $argv $config_path
    else
        nano $argv $config_path
    end
    and source $config_path
end
