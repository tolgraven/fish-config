function git_ignore --description 'remove file/dir if present, and add it to .gitignore' --argument file
test -z "$file"
or not test -e .gitignore
and return 1
git rm -r --cached $file ^&- #just ignore error in case file hasnt been added yet
echo \n$file >>.gitignore
strip_duplicate_lines_file .gitignore
end
