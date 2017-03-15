function funcmv --argument orig new
funcopy $orig $new
and funcrm $orig
and echo "function possibly called from here:"
and funcsearch $orig
echo "change calls? or abort and do manually"
echo "implement rest"
end
