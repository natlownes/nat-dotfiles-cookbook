if !exists(':Tabularize')
  finish "Tabular.vim not loaded"
endif

",a= align =
nmap <leader>a= :Tabularize 1=<CR>
vmap <leader>a= :Tabularize 1=<CR>
",a2= align ==
nmap <leader>a2= :Tabularize 1==<CR>
vmap <leader>a2= :Tabularize 1==<CR>
",a: align :
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

",a> align =>
nmap <leader>a> :Tabularize /=><cr>
vmap <leader>a> :Tabularize /=><cr>
",a- align ->
nmap <leader>a- :Tabularize /-><cr>
vmap <leader>a- :Tabularize /-><cr>
" example of only one space
"<leader>a: :Tabularize /:\zs/l0l1<cr>

" align only on first equals
AddTabularPattern! Equals=     /^[^=]*\zs=
" align only on first equals, no spaces
AddTabularPattern! Equals2==   /^[^=]*\zs=/r0c0l0
AddTabularPattern! 1=    /^[^=]*\zs=
AddTabularPattern! 1==   /^[^=]*\zs=/r0c0l0


AddTabularPattern!  assignment      /[|&+*/%<>=!~-]\@<!\([<>!=]=\|=\~\)\@![|&+*/%<>=!~-]*=/l1r1
AddTabularPattern!  two_spaces      /  /l0

AddTabularPipeline! multiple_spaces /  / map(a:lines, "substitute(v:val, '   *', '  ', 'g')") | tabular#TabularizeStrings(a:lines, '  ', 'l0')

AddTabularPipeline! argument_list   /(.*)/ map(a:lines, 'substitute(v:val, ''\s*\([(,)]\)\s*'', ''\1'', ''g'')')
                                       \ | tabular#TabularizeStrings(a:lines, '[(,)]', 'l0')
                                       \ | map(a:lines, 'substitute(v:val, ''\(\s*\),'', '',\1 '', "g")')
                                       \ | map(a:lines, 'substitute(v:val, ''\s*)'', ")", "g")')
