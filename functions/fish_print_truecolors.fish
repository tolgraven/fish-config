function fish_print_truecolors -a granularity
set -l R 00
set -l G 00
set -l B 00

while test (string length -- $R) -le 2
#echo -ns (set_color $R$G$B ^&-) $R$G$B #' '
set outround $outround (set_color $R$G$B ^&-)$R$G$B
math_hex $R +$granularity | read R
set G 00
while test (string length -- $G) -le 2
#echo -ns (set_color $R$G$B ^&-) $R$G$B #' ' l
set outround $outround (set_color $R$G$B ^&-)$R$G$B
math_hex $G +$granularity | read G
set B 00
while test (string length -- $B) -le 2
#echo -ns (set_color $R$G$B ^&-) $R$G$B #' '
set outround $outround (set_color $R$G$B ^&-)$R$G$B #' '
math_hex $B +$granularity | read B

end
end
echo $outround
set outround ''
end
end
