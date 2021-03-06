# Given a decimal number start and end print all unicode codepoint.  If $3 is specified, it's used as the current column number.
function print-decimal-unicode-range() {
    local start="$1"
    local end="$2"
    local continuedCount="$3"
    local count="${continuedCount:-0}"

    local bgColor='\x1b[48;2;54;11;0m'
    local alternateBgColor='\x1b[48;2;0;54;11m'
    local currentColor="${bgColor}"

    local allChars="${currentColor}"
    local wrapAt=25
    for decimalCode in $(seq "${start}" "${end}"); do
        local hexCode=$(printf '%x ' "${decimalCode}")
        allChars+="\u${hexCode} "
        count=$(( (count + 1) % $wrapAt))
        if [[ count -eq 0 ]]; then
            if [[ "${currentColor}" = "${alternateBgColor}" ]]; then
                currentColor="${bgColor}"
            else
                currentColor="${alternateBgColor}"
            fi
            allChars+="\n${currentColor}"
        fi
    done
    printf "${allChars}${reset_color}"
}

function print-unicode-ranges() {
    local count=0
    for ((i=1; i<=$#; i+=2)); do
        local start="$@[i]"
        local end="$@[i+1]"
        local startDecimal=$((16#$start))
        local endDecimal=$((16#$end))
        print-decimal-unicode-range "${startDecimal}" "${endDecimal}" "${count}"
        count=$(($count + $endDecimal - $startDecimal))
    done
}

function test-fonts() {
    echo "Nerd - Pomicons:"; print-unicode-ranges e000 e00a;  echo;echo
		echo "Nerd - Powerline";  print-unicode-ranges e0a0 e0a2 e0b0 e0b3;  echo;echo
    echo "Nerd - Powerline Extra";  print-unicode-ranges e0a3 e0a3 e0b4 e0c8; echo;echo
    echo "Nerd - Symbols original";  print-unicode-ranges e5fa e62a; echo;echo
    echo "Nerd - Devicons";  print-unicode-ranges e700 e7c5;  echo; echo
    echo "Nerd - Font awesome";  print-unicode-ranges f000 f295;  echo;echo
    echo "Nerd - Octicons";  print-unicode-ranges f400 f4ae;  echo;echo
    echo "Nerd - Font Linux";  print-unicode-ranges f300 f315; echo
}
