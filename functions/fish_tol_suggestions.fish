function fish_tol_suggestions
	echo "'taking fish into the late nineties'
so the focus here isnt bringing my personal pet utility functions - or whatever stuff might be more appropriate for fisherman/omf or keeping to myself - into mainline fish, but things ive thought about for a long time, have implemented and tested to various degrees and think would make sense as additions that would bring fish even closer to its design doc while maintaining or increasing uniformity and simplicity, and not being opinionated or compromising anything about what already is.
Strictly concerns itself with the interactive aspects of fish.  Almost all simple stuff merely bridging components that are already there, always with an existing paralell.
Inspirations I guess loving funced and starting to extend it a bit, stuff like using completion to inspect contents of vars, quick man page checks on the fly while editing functions, and fish_user_key_bindings (unlike other areas of customization) not meaning you're off to outside fish.
Assumptions:
Better, if doing something relevant to fish, to have the option to stay within fish.
Better, if doing something to the line being entered, to have the option to do it from that line.
The above better not involve remembering a ton of extra key bindings.

SEEMINGLY QUITE SENSIBLE NONINTRUSIVE STUFF I HAVE DONE OR AT LEAST SORT OF SEMI-ISH:

---way more mileage out of read --shell:
arred (just roll into vared tbh, incl the completion thing)
binded (fish_key_reader | read | add or edit relevant line in fish_user_key_bindings.fish)
comped / compcat (important here that higher-level completions ie. auto-generated etc get sourced by default even if theres a user completion... user shouldnt have to keep track and if want to explicitly change specific part instead of just extend then thats exactly what happens anyways!)
cliped, killed
abbed (and general system for auto-transferable abbrs)
texted, mainly to edit config.fish or something in conf.d with highlighting etc, but great for any small file/edit really

(fish_config.fish possibly as an actual function, edit file using above)
fish_colors - shows all colors as they actually look in terminal / colored (...uhm better ideas for name?) / again, something for writing this out so auto updates across boxes

'tokened', keybinding, bridging many of above to interactively edit (or more commonly in my usage, just have a look at) token, with appropriate editor (function - funced, var/array whether with \$ or not - vared/arred, --stuff - comped, file - texted), 'on top of' where currently at. Zipping through functions and vars like that just feels... bold claim but yes, almost like nearing the late nineties. Lacks discoverability, but not any more than alt-l etc does... 
-I use tput cuu/del etc to finish back where I started so its truly in-place and no mess left, tho only 'looks' equivalently smooth to how the pager comes and goes unless at basic prompt, theres some spillover above if one looks up but easy fix surely?
-Example of use together:" #make a lil screencast of below to show.
    binded #with no argument so takes a key press, write '\ep'
    #turns out unbound, so initial read is just 'bind \ep '
    bind \ep __tol_wrap_paran_left #no such function, which we can see from the color. I press \eg for my __tol_edit_token, which cant find a var or file and assumes I want to create this function, calls my "func" which is (a modified) funced + funcsave 
    #*write function*, only three lines so prob would've ended up just doing it inline otherwise, press enter, back at
    bind \ep __tol_wrap_paran_left #function is defined and ready to go!
    #enter again, done!

    echo "'But Fish Says Configurabilities are EVIL'     yes, in a sense, but the bad is HAVING to configure things, and (imo) generally the initial hurdle between using the environment, and customizing the environment... outside of the environment. Stay discoverable and in-environment and its beautiful. 

No real need to be conservative with behavior/stay "script safe", while interactive... some examples from my setup:
---Mistyping a command shouldnt result in an error message and a cleared line. The error/warning is basically already there in the syntax highlighting, so simply reinserting the failed commandline (including cursor position) and redrawing the prompt in-place makes more sense. 
---Default piping of lots of things through fish_indent --ansi if interactive... including relevant parts of errors
(personally also do stuff like pipe cat through it if input is a .fish file but I understand thats different since it wraps an external..) would say to incorporate something similar to eg grc in general, but same thing there i guess. Really makes a world of difference though, obviously doesnt interfere with scripts, and would be beautiful to have generic highlighting using the same colors one has picked for fish, out the box.

some more default nonconflicting sensible keybindings, like shift+home/end/left/right/up/down for selecting, c-k kills selection instead of line if selecting (+stops selecting). Or am I missing something?
rerun command (\e.), more up dir, properly working toggle line comment and clipboard paste. kill but to 

funcrm / funcmv / funcopy etc, not as seperate functions I guess but extensions of what currently exists that also modify the underlying environment...
varadd (+ setif or set --ifnot or whatever, short for 'set -q YESMAN; and set -U(x) YESMAN'), would write one to somewhere autoloading
cool lil line beneath showing dirh when going back and forth
hit end of dir/cmd history etc that dont consume a line
more cool comp stuff like funced showing function descs (and function descs properly updating... whats that about?), brew / apt / pip / npm showing descs... well maybe not npm
commandline --save / --restore, simple utility functions for contents and pos
(eval and replace-in-place token/job/line + revert)

WISHLIST:
recovering and resetting eg key bindings after a ctrl-c func exit?
condense error messages _and limit repetition if emitted looping_
something to keymap 'explode-abbr' for when not where that happens automatically..

read not breaking like crazy when buffer taller than term
stuff like show man page using token instead of job so actually get correct result
not jumping to end of line or buffer or whatever when completion fails
not instantly jumping all over the place when auto indenting, wait until you move to another line or similar?

completions that only show info and arent selectable. mainly due to the auto parsed stuff you could show. example: defined arguments, description etc
completions of normal fish stuff even within quoted things, colors for some symbols even within quoted things
knowledge of local vars
basic undo (hmm what does the vi mode thing do?)

LONGER-TERM I GUESS:
being able to use readline movement funcs while changing commandline...
preserved formatting in completion descs (so, like, colors in their own color when completing set_color etc)
more dynamic completions, basic semantic highlighting...

OUT THERE:
---the crazy realtime auto-auto to show hella everything. like instant autosuggestion _list_ instead of just one
lots of badman color from prompt_pwd (off osx labels/tags but also templates like bin / lib / ~)"
end
