function diff_vars -d "diff contents of shell vars" -a var1 var2
diff (echo -s $var1\n | psub) (echo -s $var2\n | psub)
end
