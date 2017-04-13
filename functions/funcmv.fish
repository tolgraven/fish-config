function funcmv --argument orig new
funcopy $orig $new
and funcrm $orig
and echo \n "function possibly called from here:"
and funcsearch $orig
echo \n "change calls? or abort and do manually"
echo "implement rest"
end
