function git_ignore -d "remove file/dir if present, and add it to .gitignore" -a file
	test -z "$file"
	and return 1
	git rm -r --cached $file; echo \n$file >> .gitignore 
end
