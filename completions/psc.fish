#!/usr/bin/env fish
# -*-  mode:fish; tab-width:4  -*-

complete -xc psc -n "__fish_use_subcommand" -a "(__fish_complete_proc | grep -v com.apple)" 
complete -xc psc -n "not __fish_use_subcommand" -a "(string split ' ' (ps -L))"
