
function! s:get_bookmarks()
  let s:plugin_dir = expand('<sfile>:p:h:h')
  let s:default_regex_bookmarks_json = s:plugin_dir . '/example.json'

  let g:regex_bookmarks_json = get(g:, 'regex_bookmarks_json', s:default_regex_bookmarks_json)

  let bookmarks_dictionary = webapi#json#decode(join(readfile(expand(g:regex_bookmarks_json)), "\n"))

  return map(bookmarks_dictionary.bookmarks, 'printf("%s", v:val.name)')
endfunc
"
" function! s:get_ext(url)
"   return fnamemodify(a:url, ':e')
" endfunction
"
" function! s:insert(str)
"   let library = filter(copy(s:list), 'v:val.name == split(a:str)[0]')[0]
"   let ext = s:get_ext(library.latest)
"   let url = library.latest
"
"   if ext ==? 'js'
"     let tag = '<script src="' . url . '"></script>'
"   elseif ext ==? 'css'
"     let tag = '<link rel="stylesheet" href="' . url . '">'
"   endif
"
"   call append(line('.'), tag)
" endfunction
"

function! s:insert()
  call append(line('.'), 'yo')
endfunction

function! regexbookmark#init()
  " call s:get_bookmarks()
  cal fzf#run({
        \ 'source':  s:get_bookmarks(),
        \ 'sink':   function('s:insert'),
        \ })
endfunction
