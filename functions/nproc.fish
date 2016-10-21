function nproc
	switch (uname)
case Darwin
sysctl -n hw.ncpu
case \*
command nproc
end
end
