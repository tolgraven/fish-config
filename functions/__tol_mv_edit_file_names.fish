function __tol_mv_edit_file_names
#SPEC: press it, you get files in dir as list, in a prompt. editing a line/file will change its name/mv it.
#SPEC: press it, you get files in dir as list, in a prompt. editing a line/file will change its name/mv it.    #blanking a line will rm/trash the file

#yanking a bunch of lines/files and later inserting in some other dir = mv files there? if can implement...
#SPEC: press it, you get files in dir as list, in a prompt. editing a line/file will change its name/mv it.    #blanking a line will rm/trash the file    #yanking a bunch of lines/files and later inserting in some other dir = mv files there? if can implement...    #ideally easy to change dirs (and update list) without having to go out and back in again
set -l IFS
set -l files (ls -A)

__tol_make_ed_right_prompt filed brred (pwd) brgreen | read -l right_prompt
set -l prompt 'printf "> "'

set -e IFS
read --prompt "$prompt" --right-prompt "$right_prompt" --command "$files" --array -l files_after

debug "pre: %s, post: %s" (count $files) (count $files_after)
end
