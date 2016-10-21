function old-update
	echo "Updating everything, hold tight... "
    spin "brew update"
    echo
    brew upgrade
    echo
    brew cask update
    echo
    brew cleanup
    echo
    brew cask cleanup
    echo
    pip3 install --upgrade pip setuptools
    echo
    pip2.7 install --upgrade pip setuptools
    echo
    npm update -g
    echo
    fisher up
    echo
    tldr --update
    fish_update_completions
    echo
    softwareupdate -ia
    echo
    type -q mas
    and mas upgrade
end
