function functions_get_desc --description 'Print the description of a Fish function.' --argument function print_completion
	if test -z $function
        #functions_get_desc functions_get_desc
        #printf 'Usage: desc { --all | function }\n'
        return 1
    end
    if test $function = '--all' # Do we want to print *all* descriptions?
        for f in (functions | sed -E 's/(.*), /\1\n/g')
            functions_get_desc $f
        end
        return 0
    else
        if not functions -q $function # Check that $argv is indeed a Fish function
            #printf '"%s" is not a function.\n' $argv
            return 1
        end
        if not functions $function | grep -q -e 'function '$function' .*--description' # Check that the function has a description
            #printf 'The function "%s" has no description.\n' $argv
            #return 2 #dont fail, easier
        end
        if not test -z $print_completion
            printf '%s\t%s\n' $function (functions $function | \
  grep 'function '$function'.*--description' | sed -E "s|.*'(.*)'.*|\1|"; or echo "function")
            return 0
        end

        #printf '%s\n' (functions $argv | \
        printf '%s\t- %s\n' $function (functions $function | \
      grep 'function '$function'.*--description' | sed -E "s|.*'(.*)'.*|\1|"; or echo "function")
    end
end
