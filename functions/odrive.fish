function odrive
	test -e ~/.odrive/bin/
    and set -l odrive_cmd ~/.odrive/bin/*/odrive.py
    or set -l odrive_cmd ~/.odrive-agent/bin/odrive #agent cli path
    eval $odrive_cmd $argv | tee -a ~/.odriveteetest | ccat
end
