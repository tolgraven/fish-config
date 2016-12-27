function odrive
	test -e ~/.odrive/bin/
    and set -l odrive_cmd ~/.odrive/bin/*/odrive.py
    or set -l odrive_cmd ~/.odrive-agent/bin/odrive #agent cli path
    set -l pipe_cmd "tee -a ~/.odriveteetest | highlight | string replace -- (pwd) '~'"
    switch "$argv[1]"
        case 'sync'
            if test (count $argv) -gt 2
                for file in $argv[2..-1]
                    test -e $file
                    and eval $odrive_cmd sync (string escape -- $file) | eval $pipe_cmd #$file 
                end
            else
                eval $odrive_cmd (string escape -- $argv) | eval $pipe_cmd
            end
        case '*'
            eval $odrive_cmd (string escape -- $argv) | eval $pipe_cmd #(string escape -- $argv) | tee -a ~/.odriveteetest | highlight | string replace -- (pwd) '~' #| ccat
    end
end
