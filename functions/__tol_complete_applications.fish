function __tol_complete_applications
	mdfind -onlyin /Applications -onlyin ~/Applications -onlyin /Developer/Applications -onlyin /opt -onlyin /usr/local/Caskroom 'kMDItemKind==Application' | sed -E 's/.+\/(.+)\.app/\1/g'
end
