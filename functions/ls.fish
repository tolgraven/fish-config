function ls
	command ls -G $argv
#    set output (command ls -G $argv)
 #   test (count $output) -gt 0
  #  and for i in (seq 1 (count $output))
   #     #echo $i
    #    #echo (count $output)
     #   #echo $output[$i]
      #  set label (get_label $output[$i]) #(pwd)/$output[$i])
       # #echo $label
        #string match -q $label None
        #or set output[$i] (string replace $output[$i] (set_color $label)$output[$i](set_color normal) "$output[$i]")
    #end
    #test -z $output
    #or echo $output
end
