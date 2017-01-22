function jump_to_function --description 'edit any function without affecting commandline' --argument function

    not test -z "$function"
    and set funky $function
    or read --prompt "" --right-prompt 'printf "%s" "dont_fuck_up"' --shell --array funky

    #echo $funky
    func $funky
    #commandline -f repaint
end
