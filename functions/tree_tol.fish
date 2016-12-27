function tree_tol
	ls -R | grep ':$' | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/' | highlight
    #grabbed offa net, work on it...
end
