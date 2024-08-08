" Good example
" https://gist.github.com/kxxoling/dcc1c3a897e6735989f32b55ef069136
"
" Yank to system clipboard
set clipboard=unnamed

" remap esc to jj  
imap jj <Esc> 

" Surround
exmap surround_wiki surround [[ ]]
exmap surround_double_quotes surround " "
exmap surround_single_quotes surround ' '
exmap surround_brackets surround ( )
exmap surround_square_brackets surround [ ]
exmap surround_curly_brackets surround { }
exmap surround_chinese_double_quotes surround “ ”
exmap surround_chinese_brackets surround 「 」

" NOTE: must use 'map' and not 'nmap'
map [[ :surround_wiki
nunmap s
vunmap s
map s" :surround_double_quotes
map s' :surround_single_quotes
map s( :surround_brackets
map s) :surround_brackets
map s[ :surround_square_brackets
map s{ :surround_curly_brackets
map s} :surround_curly_brackets
" Surround 
map s] :surround_chinese_brackets
map s\ :surround_chinese_brackets
map ss :surround_chinese_double_quotes
map sy :surround_chinese_double_quotes

" Links
exmap openlink obcommand editor:open-link-in-new-leaf
nmap go :openlink
nmap gd :openlink
