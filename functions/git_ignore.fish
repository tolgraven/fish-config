function git_ignore --description 'remove file/dir if present, and add it to .gitignore' --argument file
test -z "$file"
and return 1
not test -d .git
and not test -w .gitignore #is writable
and return 1
#not test -e .gitignore

git rm -r --cached $file ^&- #just ignore error in case file hasnt been added yet
echo \n$file >>.gitignore
strip_duplicate_lines_file .gitignore
end
