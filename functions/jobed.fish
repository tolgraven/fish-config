function jobed --description 'edit job/section in seperate prompt, reinsert when done' --argument job
	test -z $job
    and set job (commandline -j)
    set -l prompt 'fucken oath>'\n
    set -l right_prompt 'jobed editing shit yo'
    if read -c "$job" -s edited_job -p $prompt -R $right_prompt
        set -l IFS
        #return like (echo -n $edited_job | fish_indent)

    end
end
