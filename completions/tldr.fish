function __complete_tldr
    set __tldrc ~/.tldrc/tldr-master/pages/
    set -q __tldr_common
    or set -g __tldr_common (ls $__tldrc/common/ | string replace '.md' '')
    set -q __tldr_platform
    or set -g __tldr_platform (ls $__tldrc/osx/ | string replace '.md' '')
    for page in $__tldr_common
        set desc (grep --color=never ">" $__tldrc/common/$page.md)[1]
        echo -s $page \t (string sub -s 3 -l 40 $desc) #"common"
    end
    for page in $__tldr_platform
set desc (grep --color=never ">" $__tldrc/osx/$page.md)[1]   
     echo -s $page \t (string sub -s 3 -l 40 $desc)  #"osx"
    end
    #    set pages (ls ~/.tldrc/tldr-master/pages/common ~/.tldrc/tldr-master/pages/osx/ | grep -v ':' | strip_empty_lines)
    #    for file in $pages
    #        echo -s (string replace '.md' '' $file)
    #    end
end
complete -xc tldr -a "(__complete_tldr)" #"(for file in (ls ~/.tldrc/tldr-master/pages/common ~/.tldrc/tldr-master/pages/osx/ | grep -v ':'); string replace '.md' '' $file; end)"
