function toled_bind_mode
	#set -l tabwidth 2
    bind -e '!'
    bind -e '$'
    fish_default_key_bindings -M toled
    bind --mode toled \n commandline\ -i\ \\n #should make an actual sep mode evt for all this
    bind --mode toled \r commandline\ -i\ \\n
    # bind \e\n execute
    bind --mode toled \e\r execute
    bind --mode toled \co execute
    bind --mode toled \t 'commandline -i "  "'

    #set -l wrapper 'commandline -C 0; commandline -i "echo \'"; commandline -C 1000000000; commandline -i "\'"'
    bind --mode toled \cs 'set toled_exit save; commandline -C 0; and commandline -i "echo \'"; and commandline -C 1000000000; and commandline -i "\'" ; commandline -f execute'
    bind --mode toled \cq 'set toled_exit abort; commandline -C 0; and commandline -i "echo \'"; and commandline -C 1000000000; and commandline -i "\'" ; commandline -f execute'
    set fish_bind_mode toled
end
